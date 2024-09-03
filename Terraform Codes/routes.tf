resource "aws_route_table" "videotoaudiopublicroute" {
    vpc_id = aws_vpc.videotoaudiovpc.id

    route {
    cidr_block = var.routes_cidr
    gateway_id = aws_internet_gateway.videotoaudioigw.id
  }

    tags = {
      Name = "videotoaudiopublicroute"
    }
}

resource "aws_route_table_association" "Netflixroutetableassociation1" {
    route_table_id = aws_route_table.videotoaudiopublicroute.id
    subnet_id = aws_subnet.videotoaudioPublicSubnet1.id
}

resource "aws_route_table_association" "Netflixroutetableassociation" {
    route_table_id = aws_route_table.videotoaudiopublicroute.id
    subnet_id = aws_subnet.videotoaudioPublicSubnet2.id
}