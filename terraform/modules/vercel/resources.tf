#####
# Vercel
#####

resource "vercel_project" "portfolio-jd" {
  name      = "portfolio"
  framework = "nextjs"
}

resource "vercel_project_domain" "portfolio-domain" {
  project_id = vercel_project.portfolio-jd.id
  domain     = var.vercel_domain
}
data "vercel_project_directory" "portfolio-path" {
  path = "modules/vercel/app"
}

resource "vercel_deployment" "portfolio" {
  project_id  = vercel_project.portfolio-jd.id
  files       = data.vercel_project_directory.portfolio-path.files
  path_prefix = "modules/vercel/app"
  production  = true
}
