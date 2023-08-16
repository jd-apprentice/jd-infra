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

resource "aws_vpc" "dyallab_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "dyallab-vpc"
  }
}

resource "aws_internet_gateway" "dyallab_gw" {
  vpc_id = aws_vpc.dyallab_vpc.id

  tags = {
    Name = "dyallab-gw"
  }
}

resource "aws_route_table" "dyallab_route_table" {
  vpc_id = aws_vpc.dyallab_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dyallab_gw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.dyallab_gw.id
  }

  tags = {
    Name = "dyallab-route-table"
  }

}

resource "aws_route_table_association" "dyallab_route_table_association" {
  subnet_id      = aws_subnet.dyallab_subnet.id
  route_table_id = aws_route_table.dyallab_route_table.id
}

resource "aws_subnet" "dyallab_subnet" {
  vpc_id            = aws_vpc.dyallab_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.aws_zone

  tags = {
    Name = "dyallab-subnet"
  }
}

resource "aws_security_group" "allow_web" {
  name        = "allow_web"
  description = "Allow web inbound traffic"
  vpc_id      = aws_vpc.dyallab_vpc.id

  ingress {
    description = "Allow HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_web_traffic"
  }
}

resource "aws_network_interface" "dyallab_network_interface" {
  subnet_id       = aws_subnet.dyallab_subnet.id
  security_groups = [aws_security_group.allow_web.id]
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

resource "aws_route53_zone" "dyallab" {
  name = "dyallab.software"
  name_servers = [
    "ns-2048.awsdns-64.com",
    "ns-2049.awsdns-65.net",
    "ns-2050.awsdns-66.org",
    "ns-2051.awsdns-67.co.uk",
  ]
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

resource "aws_route53_record" "mx" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "dyallab.software"
  type    = "MX"
  ttl     = "14400"

  records = [
    "mx1.improvmx.com.",
    "mx2.improvmx.com.",
  ]
}

resource "aws_route53_record" "mx_txt" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "dyallab.software"
  type    = "TXT"
  ttl     = "3600"

  records = [
    "v=spf1 include:spf.improvmx.com ~all",
  ]
}

resource "aws_route53_record" "ns" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "dyallab.software"
  type    = "NS"
  ttl     = "3600"

  records = [
    aws_route53_zone.dyallab.name_servers[0],
    aws_route53_zone.dyallab.name_servers[1],
    aws_route53_zone.dyallab.name_servers[2],
    aws_route53_zone.dyallab.name_servers[3],
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
