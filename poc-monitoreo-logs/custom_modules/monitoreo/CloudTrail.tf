resource "aws_cloudtrail" "seguimientosLogs" {

  name = "${var.cluster_name}-trailLogs"
  //depends_on = ["aws_s3_bucket_policy.source"]
  s3_bucket_name                = var.s3_bucket_id
  cloud_watch_logs_role_arn     = aws_iam_role.cloud_trail.arn
  cloud_watch_logs_group_arn    = "${aws_cloudwatch_log_group.web-app.arn}:*" #enviar logs a Cloudwatch
  s3_key_prefix                 = "prefix"
  include_global_service_events = false

}

## Se configura un perfil IAM que tenga permisos para enviar logs a CloudWatch
resource "aws_iam_role" "cloud_trail" {
  name = "cloudTrail-cloudWatch-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudtrail.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "aws_iam_role_policy_cloudTrail_cloudWatch" {
  name = "cloudTrail-cloudWatch-policy"
  role = aws_iam_role.cloud_trail.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailCreateLogStream2014110",
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream"
            ],
            "Resource": [
                "${aws_cloudwatch_log_group.web-app.arn}:*"
            ]
        },
        {
            "Sid": "AWSCloudTrailPutLogEvents20141101",
            "Effect": "Allow",
            "Action": [
                "logs:PutLogEvents"
            ],
            "Resource": [
                "${aws_cloudwatch_log_group.web-app.arn}:*"
            ]
        }
    ]
}
EOF
}
