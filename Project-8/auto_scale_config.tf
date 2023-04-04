resource "aws_autoscaling_policy" "asg_cpu" {

  name                   = "asg_cpu_check"
  policy_type = "TargetTrackingScaling"
  autoscaling_group_name = module.asg.autoscaling_group_name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 40.0
  }
}

resource "aws_autoscaling_policy" "asg_requests" {

  name                   = "asg_requests_check"
  policy_type = "TargetTrackingScaling"
  autoscaling_group_name = module.asg.autoscaling_group_name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label =  "${module.alb.lb_arn_suffix}/${module.alb.target_group_arn_suffixes[0]}"
    }

    target_value = 40.0
  }
}

resource "aws_autoscaling_notification" "asg_notifications" {

  depends_on = [aws_sns_topic.asg_sns]
  group_names = [
    module.asg.autoscaling_group_name
  ]

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  topic_arn = aws_sns_topic.asg_sns.arn
}

resource "random_string" "rdm" {
  length  = 4
  special = false

}
resource "aws_sns_topic" "asg_sns" {
  name = "asg-sns-${random_string.rdm.result}"


}
resource "aws_sns_topic_subscription" "email-target" {
  topic_arn = aws_sns_topic.asg_sns.arn
  protocol  = "email"
  endpoint  = "venky.potini@gmail.com"
}
