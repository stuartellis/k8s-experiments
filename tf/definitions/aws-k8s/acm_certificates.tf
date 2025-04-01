# SPDX-FileCopyrightText: 2025-present Stuart Ellis <stuart@stuartellis.name>
#
# SPDX-License-Identifier: MIT
#

resource "aws_acm_certificate" "app_cert" {
  provider          = aws.us-east-1
  domain_name       = var.app_domain_name
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "app_cert_dns" {
  provider        = aws.us-east-1
  allow_overwrite = true
  name            = tolist(aws_acm_certificate.app_cert.domain_validation_options)[0].resource_record_name
  records         = [tolist(aws_acm_certificate.app_cert.domain_validation_options)[0].resource_record_value]
  type            = tolist(aws_acm_certificate.app_cert.domain_validation_options)[0].resource_record_type
  zone_id         = data.aws_route53_zone.domain.zone_id
  ttl             = 60
}

resource "aws_acm_certificate_validation" "app_cert_validation" {
  provider                = aws.us-east-1
  certificate_arn         = aws_acm_certificate.app_cert.arn
  validation_record_fqdns = [aws_route53_record.app_cert_dns.fqdn]
}
