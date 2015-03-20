resource "google_compute_instance" "mesos-slave" {
    count = "${var.slaves}"
    name = "${var.name}-mesos-slave-${count.index}"
    machine_type = "n1-standard-4"
    zone = "${var.zone}"
    tags = ["mesos-slave","http","https","ssh"]

    disk {
      image = "ubuntu-os-cloud/ubuntu-1404-trusty-v20150128"
      type = "pd-ssd"
    }
    
    metadata {
      mastercount = "${var.masters}"
      clustername = "${var.name}"
    }

    network_interface {
      network = "${google_compute_network.mesos-net.name}"
      access_config {
        //Ephemeral IP
      }
    }

    # define default connection for remote provisioners
    connection {
      user = "${var.gce_ssh_user}"
      key_file = "${var.gce_ssh_private_key_file}"
    }

    # install mesos, haproxy and docker
    provisioner "remote-exec" {
      scripts = [
        "../../scripts/slave_install.sh",
        "../../scripts/docker_install.sh",
        "../../scripts/common_config.sh",
        "../../scripts/slave_config.sh"
      ]
    }
}