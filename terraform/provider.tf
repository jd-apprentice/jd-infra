terraform {
  cloud {
    organization = "dyallab"

    workspaces {
      name = "jd-infra"
    }
  }
}
