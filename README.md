# 🏗️ Infra

## 📕 Overview

Terraform project that manages my Proxmox homelab. It uses [Actions Runner Controller](https://docs.github.com/en/actions/concepts/runners/actions-runner-controller) to run workflows inside my local network, and aims to mirror a cloud-like IaC workflow as closely as possible

Remote state is stored in [HCP Terraform](https://developer.hashicorp.com/terraform/cloud-docs)

## 🚀 Quickstart

Both `docker` and `make` are required for the local environment. All Terraform commands are executed inside of a container

Usage:

```bash
$ make terraform -- <command>
```

The Makefile acts as a wrapper, so any Terraform subcommand can be called:

```bash
$ make terraform -- init
$ make terraform -- plan
$ make terraform -- apply
```

Add the required variables in the tfvars file:

```bash
$ cp terraform.tfvars.example terraform.tfvars
```

As this project uses HCP Terraform as backend, you also have to add a HCP Terraform API token in the environment file:

```bash
$ cp .env.example .env
```

---

## 🔐 Security

Secrets are stored as GitHub Actions secrets and injected in the workflows to execute plan/apply steps

---

## 🤖 Automation

GitHub Actions runs `terraform plan` on pull requests and posts the output as a comment. Merging to `main` triggers `terraform apply` automatically

[Renovate](https://github.com/renovatebot/renovate) monitors the repository and opens pull requests whenever new provider versions are released
