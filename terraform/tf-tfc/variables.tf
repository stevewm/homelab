variable "terraform_cloud_token" {
  type        = string
  description = "Terraform Cloud User Token"
  sensitive   = true
}

variable "github_pat" {
  type        = string
  description = "GitHub Personal Access Token"
  sensitive   = true
}
