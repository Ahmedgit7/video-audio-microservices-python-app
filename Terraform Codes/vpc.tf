resource "aws_vpc" "videotoaudiovpc" {
    cidr_block = var.cidr_block

    tags = {
      Name = "videotoaudiovpc"
    }
}