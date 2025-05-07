output "session_manager_doc_name" {
  description = "Name of the SSM Session Manager preferences document"
  value       = aws_ssm_document.session_manager_prefs.name
}

output "agent_install_doc_name" {
  description = "Name of the SSM Agent installation document"
  value       = aws_ssm_document.ssm_agent_install.name
}

output "ssm_associations" {
  description = "IDs of the SSM associations"
  value       = aws_ssm_association.ssm_agent_association[*].association_id
}