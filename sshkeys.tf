resource "digitalocean_ssh_key" "dossh" {
  name       = "Terraform"
  public_key = file(var.ssh-public-key)
}