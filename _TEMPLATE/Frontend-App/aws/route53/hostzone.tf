locals {
  domain = "${var.namespace}.com"
}

# hosted zone
# ----------------------------------------------------------------------------
resource "aws_route53_zone" "host_zone" {
  name = local.domain

  tags = {
    name = var.namespace
  }
}


# output
# ----------------------------------------------------------------------------
output "zone" {
  value = {
    id   = aws_route53_zone.host_zone.zone_id
    name = aws_route53_zone.host_zone.name
    arn  = aws_route53_zone.host_zone.arn
  }
}
