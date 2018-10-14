resource "google_compute_instance" "db-instance-2" {
  name         = "db-instance-2"
  machine_type = "n1-standard-2"
  zone         = "us-central1-a"

#   tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "centos-6-v20180911"
    }
  }

  attached_disk{
    source = "${google_compute_disk.data.name}"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  allow_stopping_for_update = "true"

  metadata {
    enable-oslogin = "true"
  }

  service_account {
    email = "sumeet-terraform@robust-shadow-217601.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }

  # metadata_startup_script = "${file("script_bootstrap.sh")}"

  metadata {
      ssh-keys = "${var.gcp_username}:${var.gcp_publickey}"
  }

}

resource "google_compute_disk" "data" {
  name  = "data-disk"
  type  = "pd-standard"
  zone  = "us-central1-a"
  # image = ""
  size = "200"
}

# resource "random_string" "password" {
#   length = 8
# }


# ------------------------

output "IP Address" { value = "${google_compute_instance.db-instance-2.network_interface.0.access_config.0.nat_ip}" }
output "UserName" { value = "${var.gcp_username}" }

