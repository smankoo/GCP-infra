resource "google_compute_instance" "flexget" {
  name         = "flexget"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

#   tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }

  // Local SSD disk
  # scratch_disk {
  # }

  attached_disk{
    source = "${google_compute_disk.data.name}"
  }


  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = <<EOF
sudo useradd flexget -aG sudo
echo -e "Sumeet@123\nSumeet@123" | sudo passwd flexget

sudo chmod 666 /etc/ssh/sshd_config

sudo echo "PasswordAuthentication yes
ChallengeResponseAuthentication no
UsePAM yes
X11Forwarding yes
PrintMotd no
AcceptEnv LANG LC_*
Subsystem       sftp    /usr/lib/openssh/sftp-server
ClientAliveInterval 120
UseDNS no" > /etc/ssh/sshd_config

sudo chmod 644 /etc/ssh/sshd_config

EOF

}

resource "google_compute_disk" "data" {
  name  = "data-disk"
  type  = "pd-standard"
  zone  = "us-central1-a"
  # image = ""
}

# ------------------------

output "IP Address" {
  value = "${google_compute_instance.flexget.network_interface.0.access_config.0.nat_ip}"
}
