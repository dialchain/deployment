resource "aws_cloudwatch_log_group" "this" {
  name = "${var.prefix}-cloudwatch-log-group"

  tags = {
    Name        = "${lower(var.prefix)}-cloudwatch-log-group"
    Environment = var.stage_name
  }
}

resource "aws_cloudwatch_log_stream" "this" {
  name           = "${lower(var.prefix)}-cloudwatch-log-stream"
  log_group_name = aws_cloudwatch_log_group.this.name
}