#Classic load balancer link.
output "classic-lb-dns-name" {
  value = module.elb_http.this_elb_dns_name
}
