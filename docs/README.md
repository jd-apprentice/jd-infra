14/8/2023

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

15/8/2023

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


### Networking

16/8/2023

So networking in general I'm losing the only braincell I have remaining since i'm trying to have nic.ar to redirect jonathan.com.ar to both vercel (for the portfolio) and digital ocean for the remaining apps but I'm doing a mess (idk if this is possible) since the apps are being sent to vercel.

I'll update once I have a solution for this.

17/8/2023

- [x] Domains

So I've moved everything to route53, I had to add a few things to the terraform code, I needed a bit of help from people at the discord channel, to understand how DNS works, but I think I got it. If not i'll be back again tomorrow.

21/8/2023

I've removed Vercel from `nic.ar` since i'm going to resolve everything with route53. From route53 I'm going to create an `A` record for the Vercel app and a `CNAME` for the blog.

27/8/2023

Everything is working perfectly, I'm continuing with the rest of the tasks.

So about the connection to the EC2 i'm wondering if use SSH or Session Manager, i'm going to take a moment and evaluatle which is better for my case.

15/9/2023

Doing ok! I've delayed a few things since the most important services/apps are already working so no rush, the good part is that everything is now stable

01/10/2023

I've started the migration of the remaining apps to AWS, added a few things that were not part of the initial plan but that I found interesting to add and wanted to try.

- Nginx Proxy Manager
- Watchtower
- Cloudflare

Updated terraform code and added a few things to the ansible playbook.

6/10/2023

I've updated to proxy everything through nginx proxy manager, I've added a few things to the terraform code and the ansible playbook.

Expect things to be broken for a few days or more since I'm busy with other stuff haha.

9/10/2023

So i've migrated more services (app, waifuland, dolar) which now are proxied by cloudflare and nginx proxy manager, I've added a few things to the terraform code and the ansible playbook.

Also removed certificates from the old instance and nginx configuration files.

Updated the redirect to `files.jonathan.com.ar`

Remaining apps in the old instance:

- files.jonathan.com.ar
- team.bondiola.dev

Cloudflare looks like  this right now:

![IMG](https://i.imgur.com/p2MNHfu.png)

Route53 is completely empty.

Read about certbot and revoking [HERE](https://letsencrypt.org/docs/revoking/)

So i'm also going to try the email routing with cloudflare, records are updated in terraform resources.

26/10/2023

Email routing is working
Shooting myself in the foot with cloudflare + nginx proxy manager, This is gonna take a while to fix.

Portfolio is now in 2 places

next.jonathan.com.ar -> vercel
jonathan.com.ar -> ec2

So cloudflare tunnel is added and working, also migrated 2 apps to the ec2 instance which are files.jonathan.com.ar and dolar.jonathan.com.ar

Also deprecated 2 apps which are waifuland.jonathan.com.ar and app.jonathan.com.ar

02/11/2023

Everything is working fine, I'll will add more things when I want to learn something new for example kong + kinga and maybe netdata

TL;DR

Don't forget to:

- Remove the app from the instance
- Remove the nginx configuration from the instance
- Remove the domain from the DNS configuration (the old one)
- Remove the domain from the domain provider (the old one)
- Remove the certificate from the instance (old instance)
