data "aws_iam_role" "notificatie-bot-role-arn" {
  name = aws_iam_role.notification-bot-iam-role.name
}

resource "aws_chatbot_slack_channel_configuration" "notification-bot"{
  configuration_name = "notification-bot-${var.slack_channel_id}"
  iam_role_arn = data.aws_iam_role.notificatie-bot-role-arn.arn
  slack_channel_id = var.slack_channel_id 
  slack_team_id =  "T12U0LKV3"
}

resource "aws_iam_role" "notification-bot-iam-role" {
  name = "notification-bot-role"
  assume_role_policy = jsonencode ({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "management.chatbot.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        },
        {
            "Effect": "Allow",
            "Principal": {
              "Service": "chatbot.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
})
}
resource "aws_iam_role_policy" "notification-bot-policy" {
  name = "AWSChatbotServiceLinkedRolePolicy"
  role = aws_iam_role.notification-bot-iam-role.id
  
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "sns:ListSubscriptionsByTopic",
                "sns:ListTopics",
                "sns:Unsubscribe",
                "sns:Subscribe",
                "sns:ListSubscriptions"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:PutLogEvents",
                "logs:CreateLogStream",
                "logs:DescribeLogStreams",
                "logs:CreateLogGroup",
                "logs:DescribeLogGroups"
            ],
            "Resource": "arn:aws:logs:*:*:log-group:/aws/chatbot/*"
        },
        {
            "Effect": "Allow",
            "Action": [
              "codepipeline:GetPipeline",
              "codepipeline:StopPipelineExecution"
            ],
            "Resource": "*"
        }
    ]
})

}
