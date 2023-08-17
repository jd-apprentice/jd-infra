Hey! Here is a little detail about what went ok and what went wrong.

Status so far

- [x] Design infrastructure

I had no issue with this, It may not be the best design, but it works for me.

- [x] Script to run Terraform

Is half done, I have a script that runs terraform, but I need to add some more stuff to it.
I'll say no issue here.

- [x] Vercel app

Here are were the issues started, I had no idea how to do this, I had to read a lot of documentation and I'll start doing some things without a strategy, so I even if nothing broke, I got some downtime which I find not optimal for a production environment.

1. The terraform code itself was not that hard, but my first approach with the github integration doesn't work, so I went with the other option.

```
#####
# Vercel
#####

resource "vercel_project" "portfolio-jd" {
  name      = "portfolio"
  framework = "nextjs"
}

resource "vercel_project_domain" "portfolio-domain" {
  project_id = vercel_project.portfolio-jd.id
  domain     = var.domain
}
data "vercel_project_directory" "portfolio-path" {
  path = "<path-to-your-app>"
}

resource "vercel_deployment" "portfolio" {
  project_id  = vercel_project.portfolio-jd.id
  files       = data.vercel_project_directory.portfolio-path.files
  path_prefix = "<path-to-your-app>"
  production  = true
}
```

Here we are initializing the project, adding the domain and deploying the app.
With this approach we need to have a `submodule` with the app, so we can deploy it.
The command to do this is:

```bash
git submodule add <repo> <path>
```

So with this so far so good, remember at this point to have environment variables and stuff.

At this point we should be able to deploy the app. I you have never registered a domain, you may have no problems now, but if you have, you may have some issues, like me.

I had to enter to my server at digital ocean and do a few things, first delete any trace of the app from there, remove the nginx configuration file related to the app itself, remove the certificate and remove the domain from the droplet(certbot).

To remove files from the app just rm everything at `sites-available/<my-domain>` and `sites-enabled/<my-domain>`, now for the cerbot part, for that part we need to do the following.

Check the syntax with

```bash
sudo nginx -t
sudo service nginx restart
```

```bash
certbot certificates
sudo certbot delete --cert-name <my-domain>
```

Also I had to remove the domain from the DNS configuration at the network panel over digital ocean and my domain provider which in this case it is `nic.ar`

- [x] Mail forwarding

Everything went okay after I moved from `digitalocean` network to `route53`, I had to add a MX record to the domain and that was it.

Oh and for the NS records I had to add the priority in the same line like this:

```

records = [
    "10 mx1.improvmx.com.",
    "20 mx2.improvmx.com.",
  ]

```

- [x] Blog

I just had to move the `CNAME` to route53 and that was it.

TL;DR

Don't forget to:

- Remove the app from the instance
- Remove the nginx configuration from the instance
- Remove the domain from the DNS configuration (the old one)
- Remove the domain from the domain provider (the old one)
- Remove the certificate from the instance (old instance)