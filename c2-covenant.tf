# create http c2 covenant droplet
resource "digitalocean_tag" "tagTypeC2" {
  name = "C2"
}

resource "digitalocean_tag" "envTypeC2" {
  name = "Production"
}

resource "digitalocean_droplet" "c2-covenant" {
  image  = "ubuntu-18-04-x64"
  name   = "c2-covenant"
  region = "nyc3"
  size   = "s-1vcpu-1gb"
  ssh_keys = [digitalocean_ssh_key.dossh.id]

  tags = [
    digitalocean_tag.tagTypeC2.id,
    digitalocean_tag.envTypeC2.id,
  ]

  connection {
    user = "root"
    type = "ssh"
    host = self.ipv4_address
    private_key = "${file(var.ssh-private-key)}"
    timeout = "2m"
  }

  provisioner "file" {
    source = "config/nginx.covenant"
    destination = "/tmp/nginx.covenant"
  }

  provisioner "file" {
    source = "config/covenant.service"
    destination = "/etc/systemd/system/covenant.service"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /opt/covenant/",
      "git clone --recurse-submodules https://github.com/cobbr/Covenant /opt/covenant/",
      "cd /tmp",
      # install .NET Core
      "wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb",
      "dpkg -i packages-microsoft-prod.deb",
      "add-apt-repository universe",
      "apt-get update -y",
      "apt-get install -y apt-transport-https",
      "apt-get update -y",
      "apt-get install -y dotnet-sdk-2.2",
      "apt-get install -y dotnet-sdk-3.1",
      "cd /opt/covenant/",
      "dotnet build",
      "dotnet publish --configuration Release -r linux-x64 --self-contained false",
      "sudo setcap CAP_NET_BIND_SERVICE=+eip /usr/bin/dotnet"
      # todo: install docker

      # set up nginx proxy
      "apt-get install -y nginx",   
      "rm -f /etc/nginx/sites-available/default",
      "rm -f /etc/nginx/sites-enabled/default",
      "mv /tmp/nginx.covenant /etc/nginx/sites-available/nginx.covenant",
      "ln -s /etc/nginx/sites-available/nginx.covenant /etc/nginx/sites-enabled/nginx.covenant",

      # todo: certbot ssl

      # todo: auto start c2

      # todo: ufw firewall

      # enable covenant service
      "systemctl enable covenant.service",
      "shutdown -r",
    ]
  }
}

