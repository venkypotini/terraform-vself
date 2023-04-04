#Classic load balancer link.
output "classic-lb-dns-name" {
  value = module.alb.this_lb_dns_name
}
