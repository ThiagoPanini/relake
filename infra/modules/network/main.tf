/* --------------------------------------------------
FILE: main.tf @ network module

CONTEXT: Arquivo principal de construção de parte
específica da infraestrutura cabível ao contexto do
módulo em questão.

GOAL: O objetivo deste arquivo é consolidar a criação
de elementos de rede presentes na dinâmica de uso dos
recursos implantados.

RESOURCES: Os recursos aqui implantados serão:
  - Security groups
-------------------------------------------------- */

# Declarando security group da aplicação
resource "aws_security_group" "app" {
  name        = "relake-app-sg"
  description = "Permite trafego especifico de inbound e outbound para que aplicacao consiga acessar o banco de dados RDS"
  vpc_id      = var.vpc_id
}

# Definindo regra de entrada para SG: tráfego via porta 22
resource "aws_security_group_rule" "inbound-ssh" {
  security_group_id = aws_security_group.app.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Permite trafego de entrada via SSH na porta 22 de todos os enderecos"
}

# Definindo regra de saída para SG: tráfego do próprio sg
resource "aws_security_group_rule" "outbound-mysql-db" {
  security_group_id = aws_security_group.app.id
  type              = "egress"
  protocol          = "tcp"
  from_port         = 3306
  to_port           = 3306
  source_security_group_id = aws_security_group.db.id
  description       = "Permite trafego de saida via porta 3306 atraves do security group do banco de dados"
}

# Declarando security group do banco de dados
resource "aws_security_group" "db" {
  name        = "relake-db-sg"
  description = "Permite trafego especifico de inbound e outbound para que o banco de dados se torne acessivel para a aplicacao"
  vpc_id      = var.vpc_id
}

# Definindo regra de entrada para SG: tráfego via porta 22
resource "aws_security_group_rule" "inbound-mysql-app" {
  security_group_id        = aws_security_group.db.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 3306
  to_port                  = 3306
  source_security_group_id = aws_security_group.app.id
  description              = "Permite trafego de entrada via SSH na porta 22 de todos os enderecos"
}

# Definindo regra de saída para SG: tráfego do próprio sg
resource "aws_security_group_rule" "outbound-sg-db" {
  security_group_id        = aws_security_group.db.id
  type                     = "egress"
  protocol                 = "-1"
  from_port                = 0
  to_port                  = 0
  source_security_group_id = aws_security_group.db.id
  description              = "Permite todo o trafego de saida para recursos do proprio sg"
}
