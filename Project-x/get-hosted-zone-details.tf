data "aws_route53_zone" "my-zone" {
  name         = "vptel.link"
  private_zone = false
}
output "myzone-id"{
    value = data.aws_route53_zone.my-zone.zone_id
}

output "myzone-name"{
    value = data.aws_route53_zone.my-zone.name
}
