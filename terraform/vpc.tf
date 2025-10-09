# ==============================================
# 🏗️ パブリックVPC構築 (Terraform v5 対応)
# ==============================================

# -------------------------------
# 1. プロバイダー設定
# -------------------------------
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"  # 東京リージョン
}

# -------------------------------
# 2. VPC の作成
# -------------------------------
resource "aws_vpc" "vpc" {
  cidr_block = "10.10.0.0/16"
  tags = {
    Name = "test-lala-vpc-tf"
  }
}

# -------------------------------
# 3. パブリックサブネット (自動でパブリックIPを割り当て)
# -------------------------------
resource "aws_subnet" "subnet_pub_1a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.10.10.0/24"
  availability_zone       = "ap-northeast-1a"

  tags = {
    Name = "test-lala-pub1a-tf"
  }
}

# -------------------------------
# 4. インターネットゲートウェイ (v5ではvpc_idを指定しない)
# -------------------------------
resource "aws_internet_gateway" "igw" {
  tags = {
    Name = "test-lala-igw-tf"
  }
}

# -------------------------------
# 5. IGW ↔ VPC のアタッチメント (v5では別リソース)
# -------------------------------
resource "aws_internet_gateway_attachment" "igw_attach" {
  vpc_id              = aws_vpc.vpc.id
  internet_gateway_id = aws_internet_gateway.igw.id
}

# -------------------------------
# 6. パブリックルートテーブルの作成
# -------------------------------
resource "aws_route_table" "rtb_pub" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "test-lala-rtb-public"
  }
}

# -------------------------------
# 7. デフォルトルートの設定 (0.0.0.0/0 → IGW)
#     → サブネットがインターネットへ通信可能になる
# -------------------------------
resource "aws_route" "rtb_pub_default" {
  route_table_id         = aws_route_table.rtb_pub.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
  depends_on             = [aws_internet_gateway_attachment.igw_attach]
}

# -------------------------------
# 8. サブネットとルートテーブルの関連付け
#     → このサブネットはパブリックとして機能する
# -------------------------------
resource "aws_route_table_association" "assoc_pub_1a" {
  subnet_id      = aws_subnet.subnet_pub_1a.id
  route_table_id = aws_route_table.rtb_pub.id
}
