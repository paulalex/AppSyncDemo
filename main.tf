provider "aws" {
  region = "eu-west-2"
}

resource "aws_dynamodb_table" "users" {
  name           = "Users"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "UserId"
  range_key      = "Username"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "Username"
    type = "S"
  }

  tags = {
    Name        = "dynamodb-table-user"
    Environment = "demo"
  }
}

resource "aws_dynamodb_table" "orders" {
  name           = "Orders"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "OrderId"
  range_key      = "UserId"

  attribute {
    name = "OrderId"
    type = "S"
  }

  attribute {
    name = "UserId"
    type = "S"
  }

  tags = {
    Name        = "dynamodb-table-orders"
    Environment = "demo"
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

  tags = {
    Name        = "dynamodb-table-products"
    Environment = "demo"
  }
}