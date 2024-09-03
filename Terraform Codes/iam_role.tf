resource "aws_iam_role" "videotoaudioInstanceRole" {
  name = "videotoaudioInstanceRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "videotoaudioInstanceRole"
  }
}

resource "aws_iam_role_policy_attachment" "videotoaudioSecretsManagerPolicyAttachment" {
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
  role     = aws_iam_role.videotoaudioInstanceRole.name
}
