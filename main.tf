provider "aws" {
  region  = "us-west-2"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0aff18ec83b712f05"
  instance_type = "t2.micro"

  tags = { 
    Name = "Primeira instancia"
  }
}

resource "aws_lambda_function" "ShortsForCloud_lambda" {
  filename         = "teste.zip"
  function_name    = "ShortsForCloud_lambda_function"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "ShortsForCloud_lambda.handler"
  runtime          = "python3.10"
  memory_size      = 128
  timeout          = 5
}

resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_exec" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_exec.name
}