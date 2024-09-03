resource "aws_subnet" "videotoaudioPublicSubnet1" {
    vpc_id = aws_vpc.videotoaudiovpc.id
    cidr_block = var.pubcidrblock1
    availability_zone = var.pubavailaibilityzone1
    map_public_ip_on_launch = true

    tags = {
      Name = "videotoaudioPublicSubnet1"
    }
}

resource "aws_subnet" "videotoaudioPublicSubnet2" {
  vpc_id = aws_vpc.videotoaudiovpc.id
  cidr_block = var.pubcidrblock2
  availability_zone = var.pubavailaibilityzone2
  map_public_ip_on_launch = true

  tags = {
    Name = "videotoaudioPublicSubnet2"
  }
}