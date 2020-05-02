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
      "cd /opt/covenant/",
      "dotnet build",
      "dotnet publish --configuration Release",
      # install nginx      
      "apt-get install -y nginx",
      # run covenant
      "cd /opt/covenant/Covenant",
      "dotnet run"      
      # todo: setup nginx config proxy
      # todo: certbot ssl
      # todo: auto start c2
      # todo: ufw firewall
      "shutdown -r",      
    ]
  }
}

