/* --------------------------------------------------
FILE: main.tf @ rds module

CONTEXT: Arquivo principal de construção de parte
específica da infraestrutura cabível ao contexto do
módulo em questão.

GOAL: O objetivo deste arquivo é consolidar a criação
de uma instancia de banco de dados RDS utilizada como
insumo para simulacao do ambiente de movimentacao
de dados para o DataLake

RESOURCES: Os recursos aqui implantados serão:
  - Instancia de banco de dados RDS
-------------------------------------------------- */

# Definindo cluster do banco de dados
resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier = "relake-aurora-cluster"
  engine             = "aurora-mysql"
  database_name      = "relake"

  master_username = var.db_username
  master_password = var.db_password_temp
}

# Definindo instancia
resource "aws_rds_cluster_instance" "aurora_cluster_instance" {
  identifier          = "relake-aurora-cluster-instance-1"
  cluster_identifier  = aws_rds_cluster.aurora_cluster.id
  instance_class      = var.db_instance_class
  publicly_accessible = false
  engine              = "aurora-mysql"
}
# https://gist.github.com/sandcastle/4e7b979c480690044bd8

