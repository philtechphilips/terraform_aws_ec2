resource "aws_key_pair" "dove-key" {
  key_name   = "dove-key"
  public_key = var.pub_key
}