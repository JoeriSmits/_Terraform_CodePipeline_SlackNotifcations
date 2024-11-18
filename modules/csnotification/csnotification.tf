module "slack-chatbot" {
  source = "../slack-chatbot/"
  
  slack_channel_id = var.slack_channel_id
}

resource "aws_codestarnotifications_notification_rule" "notification-rule" {
  for_each = toset(var.codenotification_pipeline_arn)
  detail_type = "FULL"
  event_type_ids = ["codepipeline-pipeline-pipeline-execution-started","codepipeline-pipeline-pipeline-execution-succeeded", "codepipeline-pipeline-pipeline-execution-failed","codepipeline-pipeline-manual-approval-needed", "codepipeline-pipeline-manual-approval-succeeded"]
  name = "rule-${split(each.key, ":", 5)}"

  resource = each.key

  target {
    address = module.slack-chatbot.notification-bot-configuration-arn
    type = "AWSChatbotSlack"
  }
}
