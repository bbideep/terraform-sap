resource "aws_route53_zone" "private" {
  name = var.pvt_zone_name
  vpc {
    vpc_id = var.vpc_id
  }
}

output "pvt_zone_id" {
  value = aws_route53_zone.private.zone_id
}