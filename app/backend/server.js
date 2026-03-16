const express = require("express")
const cors = require("cors")
const { Pool } = require("pg")
const client = require("prom-client")

const app = express()

app.use(cors())
app.use(express.json())

/* PROMETHEUS METRICS */

const collectDefaultMetrics = client.collectDefaultMetrics
collectDefaultMetrics()

app.get("/metrics", async (req,res)=>{
  res.set("Content-Type", client.register.contentType)
  res.end(await client.register.metrics())
})

/* DATABASE CONNECTION */

const pool = new Pool({
  host: process.env.DB_HOST,
  user: "postgres",
  password: process.env.DB_PASSWORD,
  database: "appdb",
  port: 5432
})

async function waitForDB() {

  while (true) {
    try {
      await pool.query("SELECT 1")
      console.log("PostgreSQL connected")
      break
    } catch (err) {
      console.log("Waiting for DB...")
      await new Promise(r => setTimeout(r, 2000))
    }
  }

}

async function initDB() {

  await waitForDB()

  await pool.query(`
  CREATE TABLE IF NOT EXISTS tasks (
      id SERIAL PRIMARY KEY,
      title TEXT NOT NULL,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  )
  `)

  console.log("Table ready")
}

initDB()

/* CREATE TASK */

app.post("/tasks", async (req, res) => {

  const { title } = req.body

  const result = await pool.query(
    "INSERT INTO tasks(title) VALUES($1) RETURNING *",
    [title]
  )

  res.json(result.rows[0])

})

/* GET TASKS */

app.get("/tasks", async (req, res) => {

  const result = await pool.query(
    "SELECT * FROM tasks ORDER BY id DESC"
  )

  res.json(result.rows)

})

/* DELETE TASK */

app.delete("/tasks/:id", async (req, res) => {

  await pool.query(
    "DELETE FROM tasks WHERE id=$1",
    [req.params.id]
  )

  res.json({ message: "Deleted" })

})

app.listen(5000, () => {
  console.log("Backend running on port 5000")
})
