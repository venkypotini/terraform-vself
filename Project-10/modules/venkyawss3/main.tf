#S3 bucket creation.
resource "aws_s3_bucket" "venky-wbsite1" {
  bucket = var.bucket_name

}

#S3 Website creation
resource "aws_s3_bucket_website_configuration" "venkywbconf" {
  bucket = aws_s3_bucket.venky-wbsite1.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_policy" "mypolicy" {
  bucket = aws_s3_bucket.venky-wbsite1.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Sid": "PublicReadGetObject",
          "Effect": "Allow",
          "Principal": "*",
          "Action": [
              "s3:GetObject"
          ],
          "Resource": [
              "arn:aws:s3:::${var.bucket_name}/*"
          ]
      }
  ]
}
POLICY
}
