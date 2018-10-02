resource "google_compute_project_metadata" "ssh_keys" {
    metadata {
      ssh-keys = <<EOF
${var.gcp_username}:ssh-rsa ${var.gcp_privatekey}
EOF
    }
}