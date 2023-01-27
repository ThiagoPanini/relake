/* --------------------------------------------------
FILE: variables.tf @ rds module

CONTEXT: Arquivo de declaração de variáveis a ser 
utilizado nos recursos criados especificamente neste
módulo.

GOAL: O objetivo deste arquivo é concentrar a declaração
de variáveis para toda a configuracao da instancia
de banco de dados RDS
-------------------------------------------------- */

variable "db_username" {
  description = "Nome de usuario do banco de dados"
  type        = string
}

# Substituir por: https://stackoverflow.com/questions/65603923/terraform-rds-database-credentials
variable "db_password_temp" {
  description = "Senha do banco de dados (substituir por password aleatorio)"
  type        = string
}

variable "db_instance_class" {
  description = "Tipo de instancia alocada para servir ao banco de dados RDS"
  type        = string
}

variable "db_vpc_security_group_ids" {
  description = "Lista de security groups a serem associados ao cluster do banco de dados"
  type        = list(string)
}
