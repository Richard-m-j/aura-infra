variable "argocd_password" {
  description = "The admin password for Argo CD"
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
    instance_type = "t2.large"
    key_name      = "richardnv"
    name_tag      = "Richard_Instance"
  }
}