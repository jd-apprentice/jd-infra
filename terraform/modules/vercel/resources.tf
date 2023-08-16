#####
# Vercel
#####

resource "vercel_project" "portfolio" {
  name      = "portfolio-next-terraform"
  framework = "nextjs"
  git_repository = {
    type = "github"
    repo = var.repository
  }
}

resource "vercel_project_domain" "portfolio" {
  project_id = vercel_project.portfolio.id
  domain     = var.domain
}
