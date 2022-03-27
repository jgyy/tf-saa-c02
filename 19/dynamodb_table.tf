resource "aws_dynamodb_table" "example" {
  name           = "DemoTable"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "user_id"

  attribute {
    name = "user_id"
    type = "S"
  }
}

resource "aws_dynamodb_table_item" "jgyy" {
  table_name = aws_dynamodb_table.example.name
  hash_key   = aws_dynamodb_table.example.hash_key

  item = jsonencode({
    "user_id" : { "S" : "jgyy_123" },
    "name" : { "S" : "Jeffrey Goh" },
    "favorite_movie" : { "S" : "Memento" },
    "favorite_number" : { "N" : "42" }
  })
}

resource "aws_dynamodb_table_item" "alice" {
  table_name = aws_dynamodb_table.example.name
  hash_key   = aws_dynamodb_table.example.hash_key

  item = jsonencode({
    "user_id" : { "S" : "alice_456" },
    "name" : { "S" : "Alice Doe" },
    "favorite_movie" : { "S" : "Pocahontas" },
    "age" : { "N" : "23" }
  })
}
