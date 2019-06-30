variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "availability_zones" {
  description = "A list of availability zones in the region."
  type        = list(string)
}

variable "convert_case" {
  type        = bool
  default     = true
  description = "Convert fields to lower case."
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `namespace`, `stage`, `name` and `attributes`."
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources."
}

variable "kms_key_pending_days" {
  type        = number
  description = "Number of days the disk encryption key is kept alive after request for deletion."
  default     = 7
}

variable "namespace" {
  type        = string
  default     = ""
  description = "Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp'."
}

variable "rds_parameter_group_enabled" {
  description = "Whether to create a database parameter group."
  type        = bool
  default     = true
}

variable "rds_parameter_group_id" {
  description = "ID of the DB parameter group to associate."
  type        = string
  default     = ""
}

variable "rds_parametergroup_values" {
  type    = map(string)
  default = {}
}

variable "rds_port" {
  type        = number
  description = "The RDS Listen Port."
}

variable "rds_version" {
  type        = string
  description = "RDS version."
}

variable "rds_flavor" {
  type        = string
  description = "Flavor for the RDS instance."
}

variable "rds_replication_mode" {
  type        = string
  description = "Specifies the replication mode for the standby DB instance."
  default     = "sync"
}

variable "rds_initial_password" {
  type        = string
  description = "Password for the initial RDS user."
}

variable "rds_type" {
  type        = string
  description = "Specifies the DB engine."
}

variable "rds_volume_type" {
  type        = string
  description = "Type of the RDS data volume."
}

variable "rds_volume_size" {
  type        = string
  description = "Size of the RDS data volume."
}

variable "rds_backup_keep_days" {
  type        = string
  description = "Retention period for automatically created RDS backups."
}

variable "rds_backup_start_time" {
  type        = string
  description = "Time window for automatic RDS backup creation."
}

variable "vpc_id" {
  type        = string
  description = "Specifies the VPC ID."
}

variable "subnet_id" {
  type        = string
  description = "Specifies the subnet ID. Changing this parameter will create a new resource."
}

variable "security_group_id" {
  type = string
}

variable "stage" {
  type        = string
  default     = ""
  description = "Stage, e.g. 'prod', 'staging', 'dev'."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}
