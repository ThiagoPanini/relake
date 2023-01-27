/* --------------------------------------------------
FILE: variables.tf @ network module

CONTEXT: Arquivo de declaração de variáveis a ser 
utilizado nos recursos criados especificamente neste
módulo.

GOAL: O objetivo deste arquivo é concentrar a declaração
de variáveis para toda a construção de recursos de rede
-------------------------------------------------- */

variable "vpc_id" {
  description = "ID da VPC onde os recursos de rede serão implementados"
  type        = string
}
