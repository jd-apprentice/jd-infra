# jd-infra 🖥 

I'm migrating from digital ocean to AWS/Vercel, so I'm using this repo to keep track of my progress.

Why not amplify? Praise the sun, I mean, praise the free tier.

## Status 📊

- [x] Design infrastructure
- [x] Script to run Terraform
- [ ] Build Terraform modules
- [ ] Build Ansible playbooks
- [ ] Build Makefile
- [ ] AWS EC2 Instead of Digital Ocean Droplets
- [ ] Docker apps running on EC2
- [x] Vercel app
- [ ] Grafana/New Relic
- [ ] Lambda functions
- [ ] Mail forwarding
- [ ] Domains

In deep documentation about how everything went can be checked in [docs](./docs/README.md).

## Work in progress 🧰

![IMG](./design/Infra_V2.png)

My last braincell is working on this repo, so please be patient.

![IMG](https://media.tenor.com/DpgEL1ITpE4AAAAd/nanashi-mumei-loading.gif)

## Folder structure 📂

```
🌳 jd-infra/
┣ 📁 ansible/
┃ ┗ 📄 .gitkeep
┣ 📁 scripts/
┃ ┣ 📄 .gitkeep
┃ ┣ 📄 install-certbot.sh
┃ ┣ 📄 install-docker.sh
┃ ┗ 📄 install-nginx.sh
┣ 📁 terraform/
┃ ┣ 📁 modules/
┃ ┃ ┣ 📁 aws/
┃ ┃ ┃ ┣ 📄 output.tf
┃ ┃ ┃ ┣ 📄 provider.tf
┃ ┃ ┃ ┣ 📄 resources.tf
┃ ┃ ┃ ┣ 📄 secret.tfvars
┃ ┃ ┃ ┗ 📄 variables.tf
┃ ┃ ┣ 📁 docker/
┃ ┃ ┃ ┣ 📄 provider.tf
┃ ┃ ┃ ┣ 📄 resources.tf
┃ ┃ ┃ ┣ 📄 secret.tfvars
┃ ┃ ┃ ┗ 📄 variables.tf
┃ ┃ ┗ 📁 vercel/
┃ ┃   ┣ 📄 provider.tf
┃ ┃   ┣ 📄 resources.tf
┃ ┃   ┣ 📄 secret.tfvars
┃ ┃   ┗ 📄 variables.tf
┃ ┣ 📄 main.tf
┃ ┗ 📄 versions.tf
┣ 📄 .gitignore
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