variable "region" {
    type = string
    description = "aws region where we will be launching our instance and deploying our application"
}

variable "cidr_block" {
    type = string
    description = "CIDR Block for the Netflix VPC"
}

variable "pubcidrblock1" {
    type = string
    description = "CIDR Block for the Public Subnet 1"
}

variable "pubcidrblock2" {
    type = string
    description = "CIDR Block for the Public Subnet 2"
}

variable "pubavailaibilityzone1" {
    type = string
    description = "availaibility zone for the publicsubnet"
}

variable "pubavailaibilityzone2" {
    type = string
    description = "availability zne for 2nd public subnet"
}

variable "routes_cidr" {
    type = string
    description = "Add the cidr for route to attach internet gateway to that route table"
}

variable "ami" {
    type = string
    description = "Add the ami id of the ec2 instance that has sonarqube and jenkins running."
}

variable "instance_type" {
    type = string
    description = "Add the instance type of the instance that has sonarqube and jenkins running."
}

variable "key_name" {
    type = string
    description = "Key name of the instance that has sonarqube and jenkins running."
}

variable "volume_size" {
    type = number
    description = "Add the volume size of the instance that has sonarqube and jenkins running."
}

variable "volume_type" {
    type = string
    description = "Add the type of volume you want for the instance that has sonarqube and jenkins running."
}

variable "cluster_name" {
    type = string
    description = "Add the name of the cluster"
}

variable "node_group_name" {
    type = string
    description = "Add the name for the nodegroup"
}

variable "node_instance_type" {
    type = string
    description = "Add the instance type for your nodes"
}

variable "desired_capacity" {
  type = number
}

variable "max_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "bucket" {
  type = string
  description = "Add the name for the backend bucket"
}

variable "dynamodb_name" {
  type = string
  description = "Add the name for your dynamodb table"
}

variable "billing_mode" {
  type = string
}