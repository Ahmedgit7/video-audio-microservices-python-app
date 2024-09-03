resource "aws_instance" "videotoaudioserver" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.videotoaudioPublicSubnet1.id
  associate_public_ip_address = true
  vpc_security_group_ids = [ aws_security_group.videotoaudiosecuritygroup.id ]
  iam_instance_profile   = aws_iam_instance_profile.videotoaudioInstanceProfile.name  # Add this line

  root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
  }

  tags = {
    Name = "videotoaudioserver"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("Ahmed.pem")
    host        = self.public_ip
  }

  # Create the directory on the instance
  provisioner "remote-exec" {
    inline = [
      "mkdir -p /home/ubuntu/Scripts"
    ]
  }

  # Copy scripts to the instance
  provisioner "file" {
    source      = "${path.module}/Scripts/"
    destination = "/home/ubuntu/Scripts/"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y unzip",
      "curl 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip' -o 'awscliv2.zip'",
      "unzip awscliv2.zip",
      "sudo ./aws/install",
    ]
  }

  # Run the scripts after copying
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/Scripts/*.sh",
      "sudo chmod +x /home/ubuntu/Scripts/helm_install.sh",
      "sudo chmod +x /home/ubuntu/Scripts/kubectl_install.sh",
      "sudo chmod +x /home/ubuntu/Scripts/mongodb_install.sh",
      "sudo chmod +x /home/ubuntu/Scripts/psql_install.sh",
      "sudo chmod +x /home/ubuntu/Scripts/clone_repo.sh"
    ]
  }

  # Run the scripts after copying
  provisioner "remote-exec" {
    inline = [
      "sudo /home/ubuntu/Scripts/helm_install.sh",
      "sudo /home/ubuntu/Scripts/kubectl_install.sh",
      "sudo /home/ubuntu/Scripts/mongodb_install.sh",
      "sudo /home/ubuntu/Scripts/psql_install.sh",
      "sudo /home/ubuntu/Scripts/clone_repo.sh"
    ]
  }
}

resource "aws_iam_instance_profile" "videotoaudioInstanceProfile" {
  name = "videotoaudioInstanceProfile"
  role = aws_iam_role.videotoaudioInstanceRole.name
}

resource "helm_release" "mongodb" {
  name       = "mongodb"
  chart      = "./video-audio-microservices-python-app-main/Helm_charts/MongoDB"
  namespace  = "default"

  values = [
    file("./video-audio-microservices-python-app-main/Helm_charts/MongoDB/values.yaml")
  ]

  depends_on = [
    null_resource.update_kubeconfig
  ]
}

resource "helm_release" "postgres" {
  name       = "postgres"
  chart      = "./video-audio-microservices-python-app-main/Helm_charts/Postgres"
  namespace  = "default"

  values = [
    file("./video-audio-microservices-python-app-main/Helm_charts/Postgres/values.yaml")
  ]

  depends_on = [
    null_resource.update_kubeconfig
  ]
}

resource "helm_release" "rabbitmq" {
  name       = "rabbitmq"
  chart      = "./video-audio-microservices-python-app-main/Helm_charts/RabbitMQ"
  namespace  = "default"

  values = [
    file("./video-audio-microservices-python-app-main/Helm_charts/RabbitMQ/values.yaml")
  ]

  depends_on = [
    null_resource.update_kubeconfig
  ]
} 