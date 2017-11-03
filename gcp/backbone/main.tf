provider "google" {
  project = "${var.gcp_project}"
  region  = "${var.gcp_region}"
}

resource "google_compute_network" "network" {
  name                    = "${var.network_name}"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "front" {
  name                     = "front"
  ip_cidr_range            = "10.0.0.0/24"
  network                  = "${google_compute_network.network.self_link}"
  region                   = "${var.gcp_region}"
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "back" {
  name                     = "back"
  ip_cidr_range            = "10.0.1.0/24"
  network                  = "${google_compute_network.network.self_link}"
  region                   = "${var.gcp_region}"
  private_ip_google_access = true
}

resource "google_compute_address" "nat_gateway" {
  name = "nat-gateway"
}

resource "google_compute_instance" "nat_gateway" {
  name         = "nat-gateway"
  machine_type = "n1-standard-1"
  zone         = "${var.gcp_region}-b"

  can_ip_forward = true

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.front.self_link}"

    access_config {
      nat_ip = "${google_compute_address.nat_gateway.address}"
    }
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }

  metadata_startup_script = <<EOF
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -j MASQUERADE
EOF

  tags = ["nat-gateway"]
}

resource "google_compute_route" "default_route" {
  name             = "to-nat-gateway"
  dest_range       = "0.0.0.0/0"
  network          = "${google_compute_network.network.self_link}"
  next_hop_instance = "nat-gateway"
  next_hop_instance_zone = "${var.gcp_region}-b"
  tags             = ["nated"]
  priority         = 100
}

resource "google_compute_firewall" "local" {
  name    = "local"
  network = "${google_compute_network.network.self_link}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["10.0.0.0/16"]
}

resource "google_compute_firewall" "nat_to_gateway" {
  name    = "nat-to-gateway"
  network = "${google_compute_network.network.self_link}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_tags = ["nated"]

  target_tags = ["nat-gateway"]
}
