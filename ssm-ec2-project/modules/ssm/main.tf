# Configure SSM preferences for session logging
resource "aws_ssm_document" "session_manager_prefs" {
  name            = "SSM-SessionManagerRunShell"
  document_type   = "Session"
  document_format = "JSON"

  content = jsonencode({
    schemaVersion = "1.0"
    description   = "Document to configure Session Manager preferences"
    sessionType   = "Standard_Stream"
    inputs = {
      s3BucketName                = ""
      s3KeyPrefix                 = ""
      s3EncryptionEnabled         = true
      cloudWatchLogGroupName      = var.log_group_name
      cloudWatchEncryptionEnabled = true
      kmsKeyId                    = var.kms_key_arn
      runAsEnabled                = false
      runAsDefaultUser            = ""
    }
  })

  tags = var.config.tags
}

# Create SSM Association document for automatic agent installation
resource "aws_ssm_document" "ssm_agent_install" {
  name            = "SSM-AgentInstallation"
  document_type   = "Command"
  document_format = "YAML"
  
  content = <<DOC
schemaVersion: '2.2'
description: 'Ensure SSM Agent is installed and running'
parameters: {}
mainSteps:
  - action: 'aws:runShellScript'
    name: 'checkAndInstallSSMAgent'
    inputs:
      runCommand:
        - |
          #!/bin/bash
          # Check if SSM Agent is installed
          if ! systemctl status amazon-ssm-agent &> /dev/null; then
            echo "SSM Agent not installed or not running. Installing..."
            
            # For Amazon Linux 2
            if grep -q "Amazon Linux" /etc/os-release; then
              sudo yum install -y amazon-ssm-agent
              sudo systemctl enable amazon-ssm-agent
              sudo systemctl start amazon-ssm-agent
            
            # For Ubuntu
            elif grep -q "Ubuntu" /etc/os-release; then
              sudo snap install amazon-ssm-agent --classic
              sudo systemctl enable snap.amazon-ssm-agent.amazon-ssm-agent.service
              sudo systemctl start snap.amazon-ssm-agent.amazon-ssm-agent.service
            
            # For other distributions
            else
              echo "Unsupported OS for automatic installation"
              exit 1
            fi
            
            echo "SSM Agent installed and started"
          else
            echo "SSM Agent is already installed and running"
          fi
          
          # Verify SSM Agent is running
          if systemctl is-active amazon-ssm-agent &> /dev/null; then
            echo "SSM Agent is active"
          else
            echo "SSM Agent installation failed or service is not running"
            exit 1
          fi
DOC

  tags = var.config.tags
}

# Create SSM association to automatically install/update SSM agent
resource "aws_ssm_association" "ssm_agent_association" {
  count            = length(var.ec2_instance_ids)
  name             = aws_ssm_document.ssm_agent_install.name
  association_type = "InstanceId"
  targets {
    key    = "InstanceIds"
    values = [var.ec2_instance_ids[count.index]]
  }
}