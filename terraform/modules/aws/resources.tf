#####
# AWS
#####

resource "aws_instance" "dyallab" {
  ami               = var.aws_ami
  instance_type     = var.aws_instance_type
  availability_zone = var.aws_zone

  tags = {
    Name = "dyallab"
  }
}

resource "aws_elb" "dyallab" {
  name               = "dyallab"
  availability_zones = [var.aws_zone]

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  instances                   = [aws_instance.dyallab.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "dyallab"
  }
}

resource "aws_route53_zone" "main" {
  name = "jonathan.com.ar"
  name_servers = [
    "ns-2048.awsdns-64.com",
    "ns-2049.awsdns-65.net",
    "ns-2050.awsdns-66.org",
    "ns-2051.awsdns-67.co.uk",
  ]
}

resource "aws_route53_record" "ns" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "jonathan.com.ar"
  type    = "NS"
  ttl     = "3600"

  records = [
    aws_route53_zone.main.name_servers[0],
    aws_route53_zone.main.name_servers[1],
    aws_route53_zone.main.name_servers[2],
    aws_route53_zone.main.name_servers[3],
  ]
}

resource "aws_route53_record" "waifuland_api" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "waifuland.jonathan.com.ar"
  type    = "A"
  ttl     = "3600"

  alias {
    name                   = aws_instance.dyallab.public_ip
    zone_id                = aws_route53_zone.main.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "forward" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "jonathan.com.ar"
  type    = "MX"
  ttl     = "14400"

  records = [
    "mx1.improvmx.com.",
    "mx2.improvmx.com.",
  ]
}

resource "aws_route53_record" "forward_txt" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "jonathan.com.ar"
  type    = "TXT"
  ttl     = "3600"

  records = [
    "v=spf1 include:spf.improvmx.com ~all",
  ]
}

resource "aws_route53_record" "blog" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "blog.jonathan.com.ar"
  type    = "CNAME"
  ttl     = "43200"

  records = [
    "hashnode.network.",
  ]
}
