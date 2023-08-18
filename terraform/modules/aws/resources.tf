#### Ref https://github.com/jd-apprentice/terraform-fundamentals/blob/master/project-2/main.tf

#####
# AWS
#####

resource "aws_instance" "dyallab" {
  ami               = var.aws_ami
  instance_type     = var.aws_instance_type
  availability_zone = var.aws_zone

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.dyallab_network_interface.id
  }

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

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 443
    lb_protocol       = "https"
    ## I'm going to use this? verify ssl_certificate_id = var.aws_ssl_certificate_id
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
}

resource "aws_route53_record" "a" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "jonathan.com.ar"
  type    = "A"
  ttl     = "172800"

  records = [
    "76.76.21.21",
  ]
}

resource "aws_route53_record" "files" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "files.jonathan.com.ar"
  type    = "A"
  ttl     = "3600"

  records = ["143.244.169.211"]
}

resource "aws_route53_record" "waifuland_api" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "waifuland.jonathan.com.ar"
  type    = "A"
  ttl     = "3600"

  records = ["143.244.169.211"]
}

resource "aws_route53_record" "waifuland_fe" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "app.jonathan.com.ar"
  type    = "A"
  ttl     = "3600"

  records = ["143.244.169.211"]
}

resource "aws_route53_record" "dolar" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "dolar.jonathan.com.ar"
  type    = "A"
  ttl     = "3600"

  records = ["143.244.169.211"]
}

resource "aws_route53_record" "forward" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "jonathan.com.ar"
  type    = "MX"
  ttl     = "14400"

  records = [
    "10 mx1.improvmx.com.",
    "20 mx2.improvmx.com.",
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

resource "aws_route53_record" "dbn-tools-docs" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "dbn-tools.jonathan.com.ar"
  type    = "A"
  ttl     = "3600"

  records = [
    "185.199.108.153",
    "185.199.109.153",
    "185.199.110.153",
    "185.199.111.153"
  ]
}
