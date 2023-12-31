################################################## Inside Nginx Proxy Manager
resource "cloudflare_record" "npm" {
  zone_id = var.cloudflare_zone_id
  name    = "dns.jonathan.com.ar"
  value   = var.nginx_proxy_manager_ip
  type    = "A"
  ttl     = 3600
}

resource "cloudflare_record" "be_waifuland" {
  zone_id = var.cloudflare_zone_id
  name    = "api.waifuland.jonathan.com.ar"
  value   = var.nginx_proxy_manager_ip
  type    = "A"
  ttl     = 3600
}

resource "cloudflare_record" "fe_waifulando" {
  zone_id = var.cloudflare_zone_id
  name    = "waifuland.jonathan.com.ar"
  value   = var.nginx_proxy_manager_ip
  type    = "A"
  ttl     = 3600
}

resource "cloudflare_record" "dolar" {
  zone_id = var.cloudflare_zone_id
  name    = "dolar.jonathan.com.ar"
  value   = var.nginx_proxy_manager_ip
  type    = "A"
  ttl     = 3600
}
##################################################

resource "cloudflare_record" "portfolio" {
  zone_id = var.cloudflare_zone_id
  name    = "jonathan.com.ar"
  value   = var.vercel_ip
  type    = "A"
  ttl     = 3600
}

resource "cloudflare_record" "forward" {
  zone_id  = var.cloudflare_zone_id
  name     = "jonathan.com.ar"
  type     = "MX"
  ttl      = "14400"
  value    = "route1.mx.cloudflare.net"
  priority = 64
}

resource "cloudflare_record" "forward2" {
  zone_id  = var.cloudflare_zone_id
  name     = "jonathan.com.ar"
  type     = "MX"
  ttl      = "14400"
  value    = "route2.mx.cloudflare.net"
  priority = 15
}

resource "cloudflare_record" "forward3" {
  zone_id  = var.cloudflare_zone_id
  name     = "jonathan.com.ar"
  type     = "MX"
  ttl      = "14400"
  value    = "route3.mx.cloudflare.net"
  priority = 63
}


resource "cloudflare_record" "forward_txt" {
  zone_id = var.cloudflare_zone_id
  name    = "jonathan.com.ar"
  type    = "TXT"
  ttl     = "3600"
  value   = "v=spf1 include:_spf.mx.cloudflare.net ~all"
}

resource "cloudflare_record" "blog" {
  zone_id = var.cloudflare_zone_id
  name    = "blog.jonathan.com.ar"
  type    = "CNAME"
  ttl     = "43200"
  value   = "hashnode.network."
}

resource "cloudflare_record" "dbn-tools-docs" {
  zone_id = var.cloudflare_zone_id
  name    = "dbn-tools.jonathan.com.ar"
  type    = "A"
  ttl     = "3600"
  # value = 
  #   "185.199.108.153",
  #   "185.199.109.153",
  #   "185.199.110.153",
  #   "185.199.111.153"
}
