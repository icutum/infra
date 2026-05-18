run "sm_size_mapping_is_correct" {
  command = plan

  assert {
    condition = alltrue([
      for name, vm in module.vm : local.vms_base[name].size != "sm" || vm.cores == 1
    ])
    error_message = "sm VMs should have 1 core"
  }

  assert {
    condition = alltrue([
      for name, vm in module.vm : local.vms_base[name].size != "sm" || vm.memory == 1024
    ])
    error_message = "sm VMs should have 1024 MiB memory"
  }

  assert {
    condition = alltrue([
      for name, vm in module.vm : local.vms_base[name].size != "sm" || vm.disk == 32
    ])
    error_message = "sm VMs should have 32 GiB disk"
  }
}

run "md_size_mapping_is_correct" {
  command = plan

  assert {
    condition = alltrue([
      for name, vm in module.vm : local.vms_base[name].size != "md" || vm.cores == 2
    ])
    error_message = "md VMs should have 2 cores"
  }

  assert {
    condition = alltrue([
      for name, vm in module.vm : local.vms_base[name].size != "md" || vm.memory == 4096
    ])
    error_message = "md VMs should have 4096 MiB memory"
  }

  assert {
    condition = alltrue([
      for name, vm in module.vm : local.vms_base[name].size != "md" || vm.disk == 32
    ])
    error_message = "md VMs should have 32 GiB disk"
  }
}

run "lg_size_mapping_is_correct" {
  command = plan

  assert {
    condition = alltrue([
      for name, vm in module.vm : local.vms_base[name].size != "lg" || vm.cores == 4
    ])
    error_message = "lg VMs should have 4 cores"
  }

  assert {
    condition = alltrue([
      for name, vm in module.vm : local.vms_base[name].size != "lg" || vm.memory == 8192
    ])
    error_message = "lg VMs should have 8192 MiB memory"
  }

  assert {
    condition = alltrue([
      for name, vm in module.vm : local.vms_base[name].size != "lg" || vm.disk == 128
    ])
    error_message = "lg VMs should have 128 GiB disk"
  }
}
