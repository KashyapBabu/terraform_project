#Creating a VPC
resource "google_compute_network" "vpc" {
   name                  = "${var.name}-vpc"
   auto_create_subnetworks = "false"
}

#Creating a subnet
resource "google_compute_subnetwork" "subnet" {
   name = "${var.name}-subnet"
   ip_cidr_range = "${var.subnet_cidr}"
   network       = "${var.name}-vpc"
   depends_on = ["google_compute_network.vpc"]
   region     = "${var.region}"
}

# VPC firewall Configuration
resource "google_compute_firewall" "firewall" {
   name = "${var.name}-firewall"
   network = "${google_compute_network.vpc.name}"

   allow {
       protocol = "icmp"
   }

   allow {
       protocol = "tcp"
       ports    = ["22"]
   }

   source_ranges = ["0.0.0.0/0"] 
}

#create a new instance
resource "google_compute_instance" "default" {
   name = "secondvm"
   machine_type = "f1-micro"
   zone = "us-central1-a"
   boot_disk {
      initialize_params {
      image = "debian-cloud/debian-9"
   }
}
network_interface {
   network = "default"
   access_config {}
}

}

