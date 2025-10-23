resource "aws_instance" "web_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_pair_name
  subnet_id     = var.subnet_id   

  tags = {
    Name        = var.instance_name
    Environment = var.environment
  }
}
