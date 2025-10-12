# ===============================================
# 🏗️ 最小構成：パブリックEC2構築（Public Subnet版）
# Terraform + AWS
# ===============================================


# -------------------------------
# 1. セキュリティグループ（SG）
# -------------------------------
resource "aws_security_group" "bas_sg" {
  name        = "bas-sg"
  vpc_id      = aws_vpc.vpc.id
  description = "Allow SSH and HTTP" # SSHとHTTPを許可

  # SSH (22) 許可
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP (80) 許可
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # すべての出力通信を許可
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "test-lala-sg-bas-tf" }
}


# -------------------------------
# 2. Bas 2EC2 インスタンス
# -------------------------------
resource "aws_instance" "basec2" {
  ami                         = "ami-0d4aa492f133a3068" # Amazon Linux 2023 (東京)
  instance_type               = "t2.micro"              # 無料枠でOK
  subnet_id                   = aws_subnet.subnet_pub_1a.id
  vpc_security_group_ids      = [aws_security_group.bas_sg.id]
  key_name                    = "infra-lala" #AWSコンソール上で作成済み
  associate_public_ip_address = true         # 自動でパブリックIPを割り当て

  tags = { Name = "test-lala-ec2-bas-tf" }
}
