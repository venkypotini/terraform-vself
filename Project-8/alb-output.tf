#Application Load Balancer link.
output "alb-lb-dns-name" {
  value = module.alb.lb_dns_name
}

output "alb-lb-ID" {
  value = module.alb.lb_id
}
