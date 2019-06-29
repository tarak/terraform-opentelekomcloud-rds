module "rds_label" {
  source       = "git::https://github.com/cloudposse/terraform-terraform-label.git?ref=master"
  attributes   = var.attributes
  convert_case = var.convert_case
  delimiter    = var.delimiter
  enabled      = var.enabled
  name         = "rds"
  namespace    = var.namespace
  stage        = var.stage
  tags         = var.tags
}

locals {
  param_group_id = var.rds_parameter_group_id != "" ? var.rds_parameter_group_id : opentelekomcloud_rds_parametergroup_v3.this[0].id
}

resource "opentelekomcloud_kms_key_v1" "this" {
  count        = var.enabled ? 1 : 0
  pending_days = var.kms_key_pending_days
  key_alias    = module.rds_label.id
  is_enabled   = true
}

resource "opentelekomcloud_rds_parametergroup_v3" "this" {
  count       = var.enabled && var.rds_parameter_group_enabled ? 1 : 0
  name        = module.rds_label.id
  description = module.rds_label.id
  values      = var.rds_parametergroup_values
  datastore {
    type    = var.rds_type
    version = var.rds_version
  }
}

resource "opentelekomcloud_rds_instance_v3" "this" {
  count             = var.enabled ? 1 : 0
  name              = module.rds_label.id
  flavor            = var.rds_flavor
  availability_zone = var.availability_zones

  # ha_replication_mode = var.rds_replication_mode
  # param_group_id    = opentelekomcloud_rds_parametergroup_v3.this[0].id
  param_group_id = local.param_group_id

  vpc_id            = var.vpc_id
  subnet_id         = var.subnet_id
  security_group_id = var.security_group_id

  db {
    type     = var.rds_type
    version  = var.rds_version
    port     = var.rds_port
    password = var.rds_initial_password
  }

  volume {
    type               = var.rds_volume_type
    size               = var.rds_volume_size
    disk_encryption_id = opentelekomcloud_kms_key_v1.this[0].id
  }
  backup_strategy {
    keep_days  = var.rds_backup_keep_days
    start_time = var.rds_backup_start_time
  }
}
