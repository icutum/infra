# 🏗️ Infra

## 📕 Overview

This is a Terraform project that manages my Proxmox instance. It uses [Actions Runner Controller](https://docs.github.com/es/actions/concepts/runners/actions-runner-controller) to apply changes in my local network, and tries to mimic as much as possible a cloud environment

The state is being shared and stored remotely in [HCP Terraform](https://developer.hashicorp.com/terraform/cloud-docs)

## ⚙️ Hardware

My server consists of parts from my old gaming PC that I repurposed to tinker with Linux in general

| CPU     | RAM   | Storage           | OS             |
| ------- | ----- | ----------------- | -------------- |
| 16C/32T | 64GiB | 1TB SSD / 2TB HDD | Proxmox VE 9.1 |

## 🔐 Security

Secrets are managed in GitHub Actions to execute plan and apply steps in the workflows

## 🤖 Automation

GitHub Actions plans the infrastructure changes when a pull request is created and automatically applies them when pushing to the main branch

[Renovate](https://github.com/renovatebot/renovate) scans the repository and opens pull requests for new provider versions
