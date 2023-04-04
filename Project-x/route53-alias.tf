/*
resource "aws_route53_record" "apps" {
  zone_id = data.aws_route53_zone.my-zone.zone_id
  name    = "apps.vptel.link"
  type    = "A"

  alias {
    name                   = aws_elb.main.dns_name
    zone_id                = aws_elb.main.zone_id
    evaluate_target_health = true
  }
}
*/
