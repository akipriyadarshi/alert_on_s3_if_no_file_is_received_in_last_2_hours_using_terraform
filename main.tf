provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = "franklin-terraform"

  topic {
    topic_arn     = "arn:aws:sns:ap-south-1:269763233488:test-jugaad"
    events        = ["s3:ObjectCreated:*"]
    
  }
}

resource "aws_cloudwatch_metric_alarm" "franklin-test-terraform" {
  alarm_name                = "franklin-test-terraform"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = "38"
  metric_name               = "NumberOfMessagesPublished"
  namespace                 = "AWS/SNS"
  period                    = "180"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "This metric monitors whether there is any file uploaded to s3 bucket in last 2 hours"
  actions_enabled           = "true"
  alarm_actions             = ["arn:aws:sns:ap-south-1:269763233488:Default_CloudWatch_Alarms_Topic"]
  ok_actions                =  ["arn:aws:sns:ap-south-1:269763233488:Default_CloudWatch_Alarms_Topic"]          
  insufficient_data_actions = []
  treat_missing_data        = "breaching"

   dimensions = {
    TopicName = "test-jugaad"
  }
}




