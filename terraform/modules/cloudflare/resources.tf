resource "cloudflare_record" "forward_one" {
  zone_id  = var.cloudflare_zone_id
  name     = "jonathan.com.ar"
  type     = "MX"
  ttl      = "14400"
  value    = "route1.mx.cloudflare.net"
  priority = 64
}

resource "cloudflare_record" "forward_two" {
  zone_id  = var.cloudflare_zone_id
  name     = "jonathan.com.ar"
  type     = "MX"
  ttl      = "14400"
  value    = "route2.mx.cloudflare.net"
  priority = 15
}

resource "cloudflare_record" "forward_third" {
  zone_id  = var.cloudflare_zone_id
  name     = "jonathan.com.ar"
  type     = "MX"
  ttl      = "14400"
  value    = "route3.mx.cloudflare.net"
  priority = 63
}

resource "cloudflare_record" "txt_first" {
  zone_id = var.cloudflare_zone_id
  name    = "awsjonathan.com.ar"
  type    = "TXT"
  ttl     = "auto"
  value   = "amazonses:"
}

resource "cloudflare_record" "txt_second" {
  zone_id = var.cloudflare_zone_id
  name    = "_dmarc"
  type    = "TXT"
  ttl     = "auto"
  value   = "v=DMARC1;  p=none; rua=mailto:8f2017204af7480b9c8599b9aee007e5@dmarc-reports.cloudflare.net"
}


resource "cloudflare_record" "txt_third" {
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
  ttl     = "auto"
  value   = "hashnode.network"
}

resource "cloudflare_record" "html" {
  zone_id = var.cloudflare_zone_id
  name    = "html.jonathan.com.ar"
  type    = "CNAME"
  ttl     = "auto"
  value   = "jd-apprentice.github.io"
}

resource "cloudflare_record" "dbn_tools" {
  zone_id = var.cloudflare_zone_id
  name    = "dbn-tools.jonathan.com.ar"
  type    = "CNAME"
  ttl     = "auto"
  value   = "jd-apprentice.github.io"
}

resource "cloudflare_email_routing_address" "contacto" {
  account_id = var.cloudflare_account_id
  email      = "contacto@jonathan.com.ar"
}

resource "cloudflare_email_routing_address" "unsecure" {
  account_id = var.cloudflare_account_id
  email      = "unsecure@jonathan.com.ar"
}

resource "cloudflare_email_routing_address" "invitado" {
  account_id = var.cloudflare_account_id
  email      = "invitado@jonathan.com.ar"
}

resource "cloudflare_ruleset" "http_https" {
  account_id  = var.cloudflare_account_id
  name        = "Port 80/443 only"
  description = "Block non-HTTP/S traffic"
  kind        = "custom"
  phase       = "http_request_firewall_custom"

  rules {
    action      = "block"
    expression  = "not cf.edge.server_port in {80 443}"
    description = "Block non-HTTP/S traffic"
  }
}

resource "cloudflare_ruleset" "php_wordpress" {
  account_id  = var.cloudflare_account_id
  name        = "php_xml"
  description = "Block PHP and Wordpress"
  kind        = "custom"
  phase       = "http_request_firewall_custom"

  rules {
    action      = "block"
    expression  = "(lower(http.request.uri.path) contains 'wp-') or (lower(http.request.uri.path) contains '.php')or (lower(http.request.uri.path) contains '.xml')"
    description = "Block PHP and Wordpress"
  }
}

resource "cloudflare_access_application" "shared_app" {
  zone_id                   = var.cloudflare_zone_id
  name                      = "Shared"
  domain                    = "shared.jonathan.com.ar"
  type                      = "self_hosted"
  session_duration          = "24h"
  auto_redirect_to_identity = false
}

resource "cloudflare_access_application" "pihole_app" {
  zone_id                   = var.cloudflare_zone_id
  name                      = "Pihole"
  domain                    = "pihole.jonathan.com.ar"
  type                      = "self_hosted"
  session_duration          = "24h"
  auto_redirect_to_identity = false
}

resource "cloudflare_access_application" "logs_app" {
  zone_id                   = var.cloudflare_zone_id
  name                      = "Logs"
  domain                    = "logs.jonathan.com.ar"
  type                      = "self_hosted"
  session_duration          = "24h"
  auto_redirect_to_identity = false
}

resource "cloudflare_access_application" "shared_app_imagenes" {
  zone_id                   = var.cloudflare_zone_id
  name                      = "Shared_Imagenes"
  domain                    = "shared.jonathan.com.ar/imagenes"
  type                      = "self_hosted"
  session_duration          = "24h"
  auto_redirect_to_identity = false
}

resource "cloudflare_access_application" "ssh_app" {
  zone_id                   = var.cloudflare_zone_id
  name                      = "SSH"
  domain                    = "ssh.jonathan.com.ar"
  type                      = "ssh"
  session_duration          = "24h"
  auto_redirect_to_identity = false
}

resource "cloudflare_acess_group" "Admins" {
  zone_id = var.cloudflare_zone_id
  name    = "Admins"

  include {
    email = var.cloudflare_admin_email
  }
}

resource "cloudflare_acess_group" "Friends" {
  zone_id = var.cloudflare_zone_id
  name    = "Friends"

  include {
    email = ["@jonathan.com.ar"]
  }
}

resource "cloudflare_acess_group" "Warp" {
  zone_id        = var.cloudflare_zone_id
  name           = "Warp"
  device_posture = ["warp_enabled"]
}

resource "cloudflare_tunnel" "homelab" {
  account_id = var.cloudflare_account_id
  name       = var.cloudflare_tunnel_name
  secret     = var.cloudflare_tunnel_secret
}
