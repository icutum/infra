terraform {
  cloud {
    organization = "infra-local"

    workspaces {
      name = "infra-state"
    }
  }
}
