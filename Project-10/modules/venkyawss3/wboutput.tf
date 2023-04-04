#Output of terraform.
output "website_details" {
  value = aws_s3_bucket_website_configuration.venkywbconf.website_endpoint
}
