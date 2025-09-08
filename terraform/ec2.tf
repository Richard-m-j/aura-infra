resource "aws_instance" "web" {
  ami           = "ami-0a84ffe13366e143f"
  instance_type = "t2.large"
  key_name      = "richardnv"
  user_data = templatefile("${path.module}/setup.tftpl", {})
  tags = {
    Name = "Richard_Instance"
  }
}
