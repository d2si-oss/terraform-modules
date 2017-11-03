provider "google" {
  project = "${var.gcp_project}"
  region  = "${var.gcp_region}"
}

locals {
  create_nat_gateway = "${var.nat_gateway_subnet == "" ? 0 : 1}"
  nat_gateway_zone   = "${element(data.google_compute_zones.available.names, 0)}"
}

data "google_compute_zones" "available" {}

resource "google_compute_network" "network" {
  name                    = "${var.network_name}"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnetworks" {
  count                    = "${length(keys(var.subnetworks))}"
  name                     = "${var.network_name}-${element(keys(var.subnetworks), count.index)}"
  ip_cidr_range            = "${element(values(var.subnetworks), count.index)}"
  network                  = "${google_compute_network.network.self_link}"
  region                   = "${var.gcp_region}"
  private_ip_google_access = "${var.subnetwork_private_ip_google_access}"
}

resource "google_compute_address" "nat_gateway" {
  count = "${local.create_nat_gateway}"
  name  = "${var.network_name}-nat-gateway"
}

resource "google_compute_instance" "nat_gateway" {
  count        = "${local.create_nat_gateway}"
  name         = "${var.network_name}-nat-gateway"
  machine_type = "${var.nat_gateway_instance_type}"
  zone         = "${local.nat_gateway_zone}"

  can_ip_forward = true

  boot_disk {
    initialize_params {
      image = "${var.nat_gateway_image}"
    }
  }

  network_interface {
    subnetwork = "${var.network_name}-${var.nat_gateway_subnet}"

    access_config {
      nat_ip = "${google_compute_address.nat_gateway.address}"
    }
  }

  service_account {
    scopes = ["${var.nat_gateway_scopes}"]
  }

  metadata_startup_script = <<EOF
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -j MASQUERADE
EOF

  tags = ["nat-gateway"]
}

resource "google_compute_route" "default_route" {
  count                  = "${local.create_nat_gateway}"
  name                   = "${var.network_name}-to-nat-gateway"
  dest_range             = "0.0.0.0/0"
  network                = "${google_compute_network.network.self_link}"
  next_hop_instance      = "${google_compute_instance.nat_gateway.name}"
  next_hop_instance_zone = "${local.nat_gateway_zone}"
  tags                   = ["nated"]
  priority               = 100
}

resource "google_compute_firewall" "local" {
  count   = "${local.create_nat_gateway}"
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
  count   = "${local.create_nat_gateway}"
  name    = "${var.network_name}-nat-to-gateway"
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
