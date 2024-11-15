output "notification-bot-configuration-arn" {
  value = aws_chatbot_slack_channel_configuration.notification-bot.chat_configuration_arn
}

//values(aws_chatbot_slack_channel_configuration.notification-bot)[*].chat_configuration_arn
/*
[
    for ids in var.slack_channel_id : aws_chatbot_slack_channel_configuration.notification-bot[ids].chat_configuration_arn
  ]
*/
