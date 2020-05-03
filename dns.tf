# # c2 http proxy #2
# resource "cloudflare_record" "c2-http-a1" {
#     domain = "${var.domain-c2}"
#     name   = "${var.sub3}"
#     value  = "${digitalocean_droplet.c2-http.ipv4_address}"
#     type   = "A"
#     ttl    = 6020
# }

# c2 http server #2
resource "cloudflare_record" "c2-http-a2" {
    zone_id = var.domain-c2
    name    = var.sub-c2
    value   = digitalocean_droplet.c2-covenant.ipv4_address
    proxied = true
    type    = "A"
    ttl     = 1
}