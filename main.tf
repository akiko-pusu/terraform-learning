provider "aws" {
  profile = "default"
  region  = "${var.region}"
}

# tfstateはs3で管理するため、先にバケットを作成
resource "aws_s3_bucket" "terraform-state-storage" {
  bucket = "${var.resource-prefix}-terraform-state-storage"
  acl    = "private"

  versioning {
    enabled = true
  }
}

# tfstate管理用のロックテーブル
resource "aws_dynamodb_table" "terraform-state-lock" {
  name           = "${var.resource-prefix}-terraform-state-lock"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

# terraform自体の設定
terraform {
  required_version = ">= 0.11.7"

  # backendでは変数を利用できないので、先にバケットとテーブルを作成しておき固定値を入れる
  # backend 部分をコメントアウトしてinit -> plan, apply -> コメント解除でinitでs3に変更
  backend "s3" {
    bucket         = "usagi-terraform-state-storage"
    key            = "terraform.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "usagi-terraform-state-lock"
  }
}

