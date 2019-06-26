provider "opentelekomcloud" {
  access_key  = var.access_key
  auth_url    = var.auth_url
  domain_name = var.domain_name
  secret_key  = var.secret_key
  tenant_name = var.tenant_name
  version     = "~> 1.9"
}

data "opentelekomcloud_vpc_v1" "vpc" {
  name = "eclever-staging-vpc"
}

data "opentelekomcloud_vpc_subnet_v1" "subnet" {
  vpc_id            = "${data.opentelekomcloud_vpc_v1.vpc.id}"
  availability_zone = "eu-de-01"
}

resource "opentelekomcloud_networking_secgroup_v2" "postgresql" {
  name        = "postgresql"
  description = "postgresql security group"
}

resource "opentelekomcloud_networking_secgroup_rule_v2" "pgsql" {
  direction         = "ingress"
  ethertype         = "IPv4"
  port_range_max    = 5432
  port_range_min    = 5432
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = opentelekomcloud_networking_secgroup_v2.postgresql.id
}


module "rds" {
  source                = "../../"
  availability_zones    = ["eu-de-01"]
  rds_backup_keep_days  = "14"
  rds_backup_start_time = "23:00-00:00"
  rds_flavor            = "rds.pg.s1"
  rds_initial_password  = "iamVerYxecure!"
  # rds_parametergroup_values = {
  #   "tcp_keepalives_count" = "4"
  # }
  rds_port          = 5432
  rds_type          = "PostgreSQL"
  rds_version       = "10.0"
  rds_volume_size   = 20
  rds_volume_type   = "COMMON"
  security_group_id = opentelekomcloud_networking_secgroup_v2.postgresql.id
  subnet_id         = data.opentelekomcloud_vpc_subnet_v1.subnet.id
  vpc_id            = data.opentelekomcloud_vpc_v1.vpc.id
  namespace         = "acme"
  stage             = "staging"
}
