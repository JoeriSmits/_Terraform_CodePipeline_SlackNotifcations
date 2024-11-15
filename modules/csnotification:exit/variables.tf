variable "slack_channel_id" {
  description = "Channel ID van Slack. Is te vinden in de URL van Slack. Channel Id begint met 'CXXXXXXXX'"
  type = string
  default = ""
}

variable "codenotification_pipeline_arn" {
  description = "Het ARN van de resource waar de notificatieregel op komt. Kan alleen een Codepipeline zijn."   
  type = list(string)
  default = [""]
}
