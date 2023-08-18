# jd-infra 🖥 

I'm migrating from digital ocean to AWS/Vercel, so I'm using this repo to keep track of my progress.

Why not amplify? Praise the sun, I mean, praise the free tier.

## Status 📊

- [x] Design infrastructure
  - Start by planning and designing your infrastructure requirements before diving into implementation.

- [x] Documentation
  - Create documentation as you design, implement, and configure different components. This will help streamline the process and ensure clarity.

- [x] Script to run Terraform
  - Develop a script that automates the deployment of your infrastructure using Terraform.

- [x] Vercel app
  - Set up your Vercel app early since is the most important one.

- [x] Mail forwarding
  - Configure mail forwarding early to ensure that communication channels are established.

- [x] Blog
  - Since is only a CNAME do it early.

- [x] Domains
  - Once your infrastructure is in place, configure your domains to point to the relevant services.

- [ ] Build Terraform modules
  - Create modular Terraform configurations that define your infrastructure components. This step comes after the design phase.

- [ ] Build Ansible playbooks
  - Develop Ansible playbooks to configure and manage software on your instances. This step follows infrastructure provisioning.

- [ ] Build Makefile
  - Develop a Makefile to streamline and automate various tasks related to your project, such as building, testing, and deployment.

- [ ] AWS EC2 Instead of Digital Ocean Droplets
  - Migrate your infrastructure from Digital Ocean Droplets to AWS EC2 instances. This step can be quite involved and should come after building Terraform modules.

- [ ] Docker apps running on EC2
  - Containerize your applications and deploy them on the AWS EC2 instances using Docker.

- [ ] Grafana/New Relic
  - Set up monitoring and observability tools like Grafana or New Relic to keep track of your infrastructure's performance.

- [ ] Lambda functions
  - If applicable, develop and deploy AWS Lambda functions to handle specific tasks within your architecture.


In deep documentation about how everything went can be checked in [docs](./docs/README.md).

Expecification about other things can be found in nested folders like

- Networking [docs/networking](./docs/networking/README.md)
- Email [docs/email](./docs/email/README.md)

## Work in progress 🧰

![IMG](./design/Infra_V4.png)

My last braincell is working on this repo, so please be patient.

![IMG](https://media.tenor.com/DpgEL1ITpE4AAAAd/nanashi-mumei-loading.gif)

## Folder structure 📂

```
🌳 jd-infra/
┣ 📁 .github/
┃ ┗ 📁 workflows/
┃   ┣ 📄 git-leaks.yml - Security
┃   ┗ 📄 snyk-security.yml - Security
┣ 📁 ansible/
┃ ┣ 📁 files/
┃ ┃ ┣ 📄 jonathan.com.ar - In case we use nginx in the server
┃ ┃ ┗ 📄 nginx.conf
┃ ┣ 📁 inventory/
┃ ┃ ┣ 📄 .gitkeep
┃ ┃ ┗ 📄 hosts - Server IP are here
┃ ┣ 📁 playbook/
┃ ┃ ┣ 📄 cronjobs.yml
┃ ┃ ┣ 📄 nginx.yml
┃ ┃ ┗ 📄 prepare.yml
┃ ┗ 📄 .gitkeep
┣ 📁 design/
┃ ┣ 📄 Infra.png - Second design
┃ ┣ 📄 Infra_V1.png - First design
┃ ┣ 📄 Infra_V2.png - Third design
┃ ┗ 📄 Infra_V3.png - Actual design
┣ 📁 docs/
┃ ┣ 📁 email/
┃ ┃ ┣ 📄 README.md
┃ ┃ ┗ 📄 improvmx.png
┃ ┣ 📁 networking/
┃ ┃ ┣ 📄 README.md
┃ ┃ ┣ 📄 aws.png
┃ ┃ ┣ 📄 digital_ocean.png
┃ ┃ ┗ 📄 nic.png
┃ ┗ 📄 README.md - Personal notes about how everything went
┣ 📁 scripts/
┃ ┣ 📄 .gitkeep
┃ ┣ 📄 install-certbot.sh
┃ ┣ 📄 install-docker.sh
┃ ┣ 📄 install-nginx.sh
┣ 📁 terraform/
┃ ┣ 📁 config/
┃ ┃ ┣ 📄 .gitkeep
┃ ┃ ┣ 📄 dev.tfvars
┃ ┃ ┗ 📄 prod.tfvars
┃ ┣ 📁 modules/
┃ ┃ ┣ 📁 aws/
┃ ┃ ┃ ┣ 📄 output.tf
┃ ┃ ┃ ┣ 📄 provider.tf
┃ ┃ ┃ ┣ 📄 resources.tf
┃ ┃ ┃ ┗ 📄 variables.tf
┃ ┃ ┣ 📁 docker/
┃ ┃ ┃ ┣ 📄 provider.tf
┃ ┃ ┃ ┣ 📄 resources.tf
┃ ┃ ┃ ┗ 📄 variables.tf
┃ ┃ ┗ 📁 vercel/
┃ ┃   ┣ 📁 app/
┃ ┃   ┣ 📄 provider.tf
┃ ┃   ┣ 📄 resources.tf
┃ ┃   ┗ 📄 variables.tf
┃ ┣ 📄 Makefile
┃ ┣ 📄 main.py
┃ ┣ 📄 main.tf - Call modules here
┃ ┗ 📄 versions.tf
┣ 📄 .gitignore
┣ 📄 .gitmodules
┣ 📄 LICENSE
┣ 📄 Makefile
┗ 📄 README.md
```

## Stack 📚

- [Terraform](https://www.terraform.io/)
- [Ansible](https://www.ansible.com/)
- [AWS](https://aws.amazon.com/)
- [Docker](https://www.docker.com/)
- [Nginx](https://www.nginx.com/)
- [Grafana](https://grafana.com/)
- [Bash](https://www.gnu.org/software/bash/)
- [Excalidraw](https://excalidraw.com/)
- [Snyk](https://snyk.io/)
- [Improvmx](https://improvmx.com/)
- [Hashnode](https://hashnode.com/)