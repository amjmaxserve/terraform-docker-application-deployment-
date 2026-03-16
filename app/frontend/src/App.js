import { useEffect, useState } from "react"

function App() {

  const API = "http://192.168.29.88:5000"

  const [tasks,setTasks] = useState([])
  const [title,setTitle] = useState("")

  async function loadTasks() {

    const res = await fetch(API + "/tasks")
    const data = await res.json()
    setTasks(data)

  }

  async function addTask() {

    await fetch(API + "/tasks",{

      method:"POST",

      headers:{
        "Content-Type":"application/json"
      },

      body:JSON.stringify({title})

    })

    setTitle("")
    loadTasks()

  }

  async function deleteTask(id){

    await fetch(API + "/tasks/" + id,{
      method:"DELETE"
    })

    loadTasks()

  }

  useEffect(()=>{
    loadTasks()
  },[])

  return (

    <div style={{padding:"40px"}}>

      <h1>Task Manager</h1>

      <input
        value={title}
        onChange={e=>setTitle(e.target.value)}
        placeholder="New task"
      />

      <button onClick={addTask}>
        Add
      </button>

      <ul>

        {tasks.map(t=>(
          <li key={t.id}>

            {t.title}

            <button onClick={()=>deleteTask(t.id)}>
              delete
            </button>

          </li>
        ))}

      </ul>

    </div>

  )

}

export default App
