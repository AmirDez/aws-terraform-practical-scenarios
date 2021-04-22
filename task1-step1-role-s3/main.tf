/* 
Task1 Step1
Create a role with s3 access:
It will create an access role to s3 service
*/

resource "aws_iam_role" "s3_role" {
  name = "s3_role"
  assume_role_policy = jsonencode({
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "s3.amazonaws.com"
        }
      },
    ]
  })
  tags = {
    tag-key = "bs-aws"
  }
}