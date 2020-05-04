# # create http redirector droplet
# resource "digitalocean_tag" "tagTypeC2rdr" {
#   name = "C2"
# }

# resource "digitalocean_tag" "envTypeC2rdr" {
#   name = "Production"
# }

# resource "digitalocean_droplet" "c2-covenant-relay" {
#   image  = "ubuntu-18-04-x64"
#   name   = "c2-covenant-relay"
#   region = "nyc3"
#   size   = "s-1vcpu-1gb"
#   ssh_keys = [digitalocean_ssh_key.dossh.id]

#   tags = [
#     digitalocean_tag.tagTypeC2rdr.id,
#     digitalocean_tag.envTypeC2rdr.id,
#   ]

#   connection {
#     user = "root"
#     type = "ssh"
#     host = self.ipv4_address
#     private_key = file(var.ssh-private-key)
#     timeout = "2m"
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "apt-get update -y",
#       "apt install -y socat",
#       "echo \"@reboot root socat TCP4-LISTEN:80,fork TCP4:${digitalocean_droplet.c2-covenant.ipv4_address}:80\" >> /etc/cron.d/mdadm",
#       "echo \"@reboot root socat TCP4-LISTEN:443,fork TCP4:${digitalocean_droplet.c2-covenant.ipv4_address}:443\" >> /etc/cron.d/mdadm",
#       "shutdown -r",
#     ]
#   }
# }

