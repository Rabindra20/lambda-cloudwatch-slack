resource "aws_sns_topic" "cloudwatch" {
  name         = "alarm"
  display_name = "alarm"
  tags         = {
    Name = "alarm"
  }
}
data "aws_iam_policy_document" "alarm_sns_policy_doc" {
  statement {
    actions   = ["sns:Publish"]
    resources = [aws_sns_topic.cloudwatch.arn]

    principals {
      identifiers = ["cloudwatch.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_sns_topic_policy" "alarm_sns_topic_policy" {
  depends_on = [aws_sns_topic.cloudwatch]
  arn        = aws_sns_topic.cloudwatch.arn
  policy     = data.aws_iam_policy_document.alarm_sns_policy_doc.json

}

resource "aws_sns_topic_subscription" "alarm_sns_subs" {
  depends_on = [aws_lambda_function.test_lambda]
  endpoint   = aws_lambda_function.test_lambda.arn
  protocol   = "lambda"
  topic_arn  = aws_sns_topic.cloudwatch.arn
}