provider "aws" {
  region = "eu-west-2"
}

locals {
  Environment = "demo"
  AppName = "appsync-demo"
  order_table_arn ="/${local.AppName}/dynamo-table/orders"
  users_table_arn ="/${local.AppName}/dynamo-table/users"
  products_table_arn ="/${local.AppName}/dynamo-table/products"
}

resource "aws_dynamodb_table" "users" {
  name           = "Users"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "UserId"

  attribute {
    name = "UserId"
    type = "S"
  }

  tags = {
    Name        = "dynamodb-table-user"
    Environment = local.Environment
  }
}

resource "aws_dynamodb_table" "orders" {
  name           = "Orders"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "OrderId"

  attribute {
    name = "OrderId"
    type = "S"
  }

  tags = {
    Name        = "dynamodb-table-orders"
    Environment = local.Environment
  }
}

resource "aws_dynamodb_table" "products" {
  name           = "Products"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "ProductId"

  attribute {
    name = "ProductId"
    type = "S"
  }
}

resource "aws_ssm_parameter" "user_table_arn" {
  name  = local.users_table_arn
  type  = "String"
  value = aws_dynamodb_table.users.arn
}

resource "aws_ssm_parameter" "order_table_arn" {
  name  = local.order_table_arn
  type  = "String"
  value = aws_dynamodb_table.orders.arn
}

resource "aws_ssm_parameter" "product_table_arn" {
  name  = local.products_table_arn
  type  = "String"
  value = aws_dynamodb_table.products.arn
}