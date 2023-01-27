/* --------------------------------------------------
FILE: outputs.tf @ network module

CONTEXT: Arquivo de definição de outputs a serem usados
em arquivos externos à este módulo.

GOAL: O objetivo deste arquivo é expor algumas variáveis,
atributos ou elementos criados neste módulo de redes
para serem utilizados em outros módulos ou mesmo na 
especificação da infraestrutura no arquivo de
configuração root. De maneira prática, o ID da VPC ou
bloco cidr podem ser informações úteis a serem utilizados
em uma série de outros recursos declarados no projeto.
-------------------------------------------------- */

# Explorando id do security group criado
output "database_security_group_id" {
  value       = aws_security_group.db.id
  description = "Id do security group criado para o banco de dados RDS Aurora"
}
