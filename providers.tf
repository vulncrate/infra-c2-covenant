provider "digitalocean" {
  token = var.do-token
}

provider "cloudflare" {
    version = "~> 2.0"
    email = var.cf-email
    api_key  = var.cf-apikey
}