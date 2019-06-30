output "rds_id" {
  value       = var.enabled ? concat(module.rds.id, [""])[0] : ""
  description = "The ID of the RDS."
}
