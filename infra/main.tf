/* --------------------------------------------------
FILE: main.tf @ root module

CONTEXT: Arquivo principal de construção da infra que,
através das informações contidas nos outros arquivos
.tf e nos módulos especificados em ./modules, realiza
a especificação dos elementos a serem implantados
nos providers declarados.

MODULES: A organização da infra comporta os módulos:
  - ./modules/rds

Especificações e detalhes sobre o conteúdo de cada
módulo poderá ser encontrado em seus respectivos
arquivos main.tf
-------------------------------------------------- */

# Definindo data sources para auxiliar na nomenclatura de variáveis
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

# Coletando VPC default da conta
data "aws_vpc" "default" {
  default = true
}

# Definindo variáveis locais para uso no módulo
locals {
  account_id  = data.aws_caller_identity.current.account_id
  region_name = data.aws_region.current.name
}


/* --------------------------------------------------
------------- MÓDULO TERRAFORM: network -------------
         Recursos de rede usados no projeto
-------------------------------------------------- */

# Chamando módulo
module "network" {
  source = "./modules/network"

  vpc_id = data.aws_vpc.default.id
}


/* --------------------------------------------------
--------------- MÓDULO TERRAFORM: rds ---------------
  Criando recursos de bancos de dados relacionais
-------------------------------------------------- */

# Chamando modulo
module "rds" {
  source = "./modules/rds"

  db_username       = var.db_username
  db_password_temp  = var.db_password_temp
  db_instance_class = var.db_instance_class

  db_vpc_security_group_ids = [module.network.database_security_group_id]
}


/* --------------------------------------------------
------------- MÓDULO TERRAFORM: storage -------------
      Criando recursos de armazenamento na conta
-------------------------------------------------- */


# Chamando módulo storage
module "storage" {
  source = "./modules/storage"

  bucket_name                 = "relake-dms-migration-${local.account_id}-${local.region_name}"
  flag_s3_block_public_access = var.flag_s3_block_public_access
}
