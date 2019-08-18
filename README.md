# terraform-opentelekomcloud-rds
Terraform module which creates RDS resources on Open Telekom Cloud


```
module "rds" {

  source  = "../../../terraform-opentelekomcloud-rds"
  enabled = true

  availability_zones          = var.availability_zones_per_vpc[terraform.workspace]
  namespace                   = var.organization
  rds_backup_keep_days        = var.rds_backup_keep_days[terraform.workspace]
  rds_backup_start_time       = var.rds_backup_start_time[terraform.workspace]
  rds_flavor                  = var.rds_flavor[terraform.workspace]
  rds_initial_password        = var.rds_initial_password[terraform.workspace]
  rds_parameter_group_enabled = false
  rds_port                    = var.rds_port
  rds_type                    = "PostgreSQL"
  rds_version                 = var.rds_version[terraform.workspace]
  rds_volume_size             = var.rds_volume_size[terraform.workspace]
  rds_volume_type             = var.rds_volume_type[terraform.workspace]
  security_group_id           = opentelekomcloud_networking_secgroup_v2.rds.id
  stage                       = terraform.workspace
  subnet_id                   = data.opentelekomcloud_vpc_subnet_v1.subnet.id
  vpc_id                      = data.opentelekomcloud_vpc_v1.vpc.id
}
```
