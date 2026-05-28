# 🏗️ Infra

## 📕 Overview

Terraform project that manages my Proxmox homelab. It uses [Actions Runner Controller](https://docs.github.com/en/actions/concepts/runners/actions-runner-controller) to run workflows inside my local network, and aims to mirror a cloud-like IaC workflow as closely as possible

Remote state is stored in [HCP Terraform](https://developer.hashicorp.com/terraform/cloud-docs)

---

## 🔐 Security

Secrets are stored as GitHub Actions secrets and injected in the workflows to execute plan/apply steps

---

## 🤖 Automation

GitHub Actions handles the full Terraform lifecycle:
- Pull request: `terraform plan` is run and the output is posted as a PR comment
- Push to `main`: `terraform apply` is executed automatically

[Renovate](https://github.com/renovatebot/renovate) monitors the repository and opens pull requests whenever new provider versions are released.
