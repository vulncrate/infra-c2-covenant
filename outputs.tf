output "outputs" {
  value = [
    "Covenant C2 http a1 ${digitalocean_droplet.c2-covenant.ipv4_address}", 
    ]
}