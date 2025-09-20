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
    argocd_password      = var.argocd_password
    grafana_password     = var.grafana_password
    aws_access_key_id    = var.aws_access_key_id
    aws_secret_access_key = var.aws_secret_access_key
  })

  tags = {
    Name = var.instance_configuration.name_tag
  }
}