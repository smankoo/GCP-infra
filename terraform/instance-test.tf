resource "google_compute_instance" "test" {
  name         = "test"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

#   tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
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

  metadata_startup_script = "${file("script_bootstrap.sh")}"

}

resource "google_compute_disk" "data" {
  name  = "data-disk"
  type  = "pd-standard"
  zone  = "us-central1-a"
  # image = ""
  size = "20"
}

resource "random_string" "password" {
  length = 8
}


# ------------------------

output "IP Address" { value = "${google_compute_instance.test.network_interface.0.access_config.0.nat_ip}" }
output "UserName" { value = "${var.gcp_username}" }

