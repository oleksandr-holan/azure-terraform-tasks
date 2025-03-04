output "sql_server_fqdn" {
  description = "SQL server FQDN"
  value       = module.sql.fqdn
}

output "app_hostname" {
  description = "App Hostname"
  value       = module.webapp.hostname
}
