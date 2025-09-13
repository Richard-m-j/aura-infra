resource "aws_instance" "web" {
  ami           = var.instance_configuration.ami
  instance_type = var.instance_configuration.instance_type
  key_name      = var.instance_configuration.key_name
  
  instance_market_options {
    market_type = "spot"
    spot_options {
      instance_interruption_behavior = "terminate"
    }
  }
  user_data = templatefile("${path.module}/setup.sh", {
    argocd_password = var.argocd_password
    grafana_password = var.grafana_password
  })

  tags = {
    Name = var.instance_configuration.name_tag
  }
}