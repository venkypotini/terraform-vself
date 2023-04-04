
resource "aws_route53_record" "app1-vptel" {
  zone_id = data.aws_route53_zone.my-zone.zone_id
  name    = "app1.vptel.link"
  type    = "A"

  alias {
    name                   = module.alb.lb_dns_name
    zone_id                = module.alb.lb_zone_id
    evaluate_target_health = true
  }
}


resource "aws_route53_record" "app2-vptel" {
  zone_id = data.aws_route53_zone.my-zone.zone_id
  name    = "app2.vptel.link"
  type    = "A"

  alias {
    name                   = module.alb.lb_dns_name
    zone_id                = module.alb.lb_zone_id
    evaluate_target_health = true
  }
}
