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
      certificate_arn = "arn:aws:acm:eu-west-2:631344605420:certificate/3e9089cb-b4ec-4746-9fd3-066101c16ccf"
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
      priority = 1

      actions = [
        {
          type               = "forward"
          target_group_index = 0
        }
      ]

      conditions = [{
        http_headers = [{
          http_header_name = "custom-header-1"
          values           = ["app1", "app-1", "my-app-1"]
        }]
      }]
    }
    ,
    {
      https_listener_index = 0
      priority = 2

      actions = [
        {
          type               = "forward"
          target_group_index = 1
        }
      ]

      conditions = [{
        http_headers = [{
          http_header_name = "custom-header-2"
          values           = ["app2", "app-2", "my-app-2"]
        }]
      }]
  },
      {
      https_listener_index = 0
      priority = 3

      actions = [
        {
        type        = "redirect"
        status_code = "HTTP_302"
        host        = "www.youtube.com"
        path        = "/watch"
        query       = "v=dQw4w9WgXcQ"
        protocol    = "HTTPS"

        }
      ]

      conditions = [{
        query_strings = [{
          key   = "video"
          value = "random"
        }]
      }]

  }]




}
