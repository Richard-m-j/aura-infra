variable "argocd_password" {
  description = "The admin password for Argo CD"
  type        = string
  sensitive   = true
}

variable "grafana_password" {
  description = "The admin password for Grafana"
  type        = string
  sensitive   = true
}

variable "aws_access_key_id" {
  description = "AWS Access Key ID"
  type        = string
  sensitive   = true
}

variable "aws_secret_access_key" {
  description = "AWS Secret Access Key"
  type        = string
  sensitive   = true
}

variable "instance_configuration" {
  description = "Configuration for the EC2 instance"
  type        = object({
    ami           = string
    instance_type = string
  
  key_name      = string
    name_tag      = string
  })
  default = {
 
   ami           = "ami-04f59c565deeb2199"
    instance_type = "t3.large"
    key_name      = "richardnv"
    name_tag      = "Richard_Instance"
  }
}