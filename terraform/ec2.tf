resource "aws_instance" "web" {
  ami           = "ami-04f59c565deeb2199"
  instance_type = "t2.large"
  key_name      = "richardnv"
  user_data     = file("${path.root}/setup.sh")
  tags = {
    Name = "Richard_Instance"
  }
}
