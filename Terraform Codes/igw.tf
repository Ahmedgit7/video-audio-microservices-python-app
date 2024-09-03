resource "aws_internet_gateway" "videotoaudioigw" {
    vpc_id = aws_vpc.videotoaudiovpc.id

    tags = {
      Name = "videotoaudioigw"
    }
}