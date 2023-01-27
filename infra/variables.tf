/* --------------------------------------------------
FILE: variables.tf @ root module

CONTEXT: Arquivo de especificação de variáveis a serem
utilizadas no módulo root desta especificação de infra

GOAL: O objetivo deste arquivo é centralizar a declaração
de variáveis importantes para o projeto, se tornando 
então uma foram de agilizar o desenvolvimento do código
através de um local organizado para uso das variáveis.
As variáveis alocadas neste arquivo são de uso 
exclusivo do arquivo main.tf no módulo root.
-------------------------------------------------- */

variable "aws_provider_config" {
  description = "Caminhos de configuração e credenciais do provedor AWS"
  type        = map(any)
  default = {
    "config"      = ["~/.aws/config"]
    "credentials" = ["~/.aws/credentials"]
  }
}

/* --------------------------------------------------
--------------- VARIÁVEIS: módulo rds ---------------
-------------------------------------------------- */

variable "db_instance_class" {
  description = "Tipo de instancia alocada para servir ao banco de dados RDS"
  type        = string
  default     = "db.t3.medium"
}

variable "db_username" {
  description = "Nome de usuario do banco de dados"
  type        = string
  default     = "relakeuser"
}

# Substituir por: https://stackoverflow.com/questions/65603923/terraform-rds-database-credentials
variable "db_password_temp" {
  description = "Senha do banco de dados (substituir por password aleatorio)"
  type        = string
  default     = "1234567%"
}

/* --------------------------------------------------
------------ VARIÁVEIS: módulo storage --------------
-------------------------------------------------- */

variable "flag_s3_block_public_access" {
  description = "Flag para configuração de bloqueio de acesso público de buckets criados"
  type        = bool
  default     = true
}
