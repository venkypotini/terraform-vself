module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = "my-alb"

  load_balancer_type = "application"

  vpc_id          = module.vpc.vpc_id
  subnets         = [module.vpc.public_subnets[0], module.vpc.public_subnets[1]]
  security_groups = [aws_security_group.elb_security.id]

  target_groups = [
    {
      name_prefix      = "app1"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      targets = {
        my_target = {
          target_id = module.ec2-private-app1.id[0]
          port      = 80
        }
        my_other_target = {
          target_id = module.ec2-private-app1.id[1]
          port      = 80
        }
      }
    }
    ,
    {
      name_prefix      = "app2"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      targets = {
        my_target = {
          target_id = module.ec2-private-app2.id[0]
          port      = 80
        }
        my_other_target = {
          target_id = module.ec2-private-app2.id[1]
          port      = 80
        }
      }
    }
  ]

  https_listeners = [
    {
      port            = 443
      protocol        = "HTTPS"
      certificate_arn = module.acm.acm_certificate_arn
      action_type     = "fixed-response"
      fixed_response = {
        content_type = "text/plain"
        message_body = "Fixed message"
        status_code  = "200"
      }

    }
  ]

  http_tcp_listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]
  https_listener_rules = [
    {
      https_listener_index = 0

      actions = [
        {
          type               = "forward"
          target_group_index = 0
        }
      ]

      conditions = [{
        #path_patterns = ["/app1*"]
        host_headers = ["app1.vptel.link"]
      }]
    }
    ,
    {
      https_listener_index = 0

      actions = [
        {
          type               = "forward"
          target_group_index = 1
        }
      ]

      conditions = [{
        #path_patterns = ["/app2*"]
        host_headers = ["app2.vptel.link"]
      }]
  }]




}
