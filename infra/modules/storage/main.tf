/* --------------------------------------------------
FILE: main.tf @ storage module

CONTEXT: Arquivo principal de construção de parte
específica da infraestrutura cabível ao contexto do
módulo em questão.

GOAL: O objetivo deste arquivo é consolidar a criação
de um bucket s3 alvo de todo o armazemaneto das fontes
de dados a serem utilizadas como origens do script
glue implantado.

RESOURCES: Os recursos aqui implantados serão:
  - Bucket S3 para dados migrados via DMS
-------------------------------------------------- */

# Definindo bucket s3
resource "aws_s3_bucket" "this" {
  bucket        = var.bucket_name
  force_destroy = true
}

# Definindo bloqueio de acesso público ao bucket
resource "aws_s3_bucket_public_access_block" "all_private" {
  count  = var.flag_s3_block_public_access ? 1 : 0
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Criptografando bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.this.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}
