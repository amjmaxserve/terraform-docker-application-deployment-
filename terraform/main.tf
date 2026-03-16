module "network" {

  source = "./modules/network"

  network_name = "app_network"

}

module "postgres" {

  source = "./modules/postgres"

  network = module.network.network_name

  password = "postgres"

}

module "backend" {

  source = "./modules/backend"

  network = module.network.network_name

  db_host = "postgres_db"

  db_password = "postgres"

}

module "frontend" {

  source = "./modules/frontend"

  network = module.network.network_name

}

module "observability" {

  source = "./modules/observability"

  network = module.network.network_name

}
