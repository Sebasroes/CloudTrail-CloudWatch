#####################
# Creamos un grupo de registors en CloudWatch
#####################
resource "aws_cloudwatch_log_group" "web-app" {
  name = "${var.cluster_name}-logs"

  tags = {
    Application = "${var.cluster_name}"
  }
}
