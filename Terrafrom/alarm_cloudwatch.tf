resource "aws_cloudwatch_metric_alarm" "cloudwatch_metric_alarm" {
  alarm_name                = "cpu-high-ecs"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/ECS"
  period                    = 120
  statistic                 = "Average"
  threshold                 = 80
  alarm_description         = "This metric monitors ecs cpu utilization"
  insufficient_data_actions = []
  actions_enabled           = "true"
  alarm_actions             = [aws_sns_topic.cloudwatch.arn]
#   ok_actions                = [aws_sns_topic.cloudwatch.arn]
  dimensions = {
          "ClusterName" = "ecs"
          "ServiceName" = "ecs"
  }
}