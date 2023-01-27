/* --------------------------------------------------
FILE: variables.tf @ storage module

CONTEXT: Arquivo de declaração de variáveis a ser 
utilizado nos recursos criados especificamente neste
módulo.

GOAL: O objetivo deste arquivo é concentrar a declaração
de variáveis para toda a construção do ambiente de
armazenamento dos dados e insumos no s3
-------------------------------------------------- */

variable "bucket_name" {
  description = "Nome do bucket a ser criado"
  type        = string
}

variable "flag_s3_block_public_access" {
  description = "Flag para configuração de bloqueio de acesso público de buckets criados"
  type        = bool
}
