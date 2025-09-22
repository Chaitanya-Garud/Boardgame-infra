#!/bin/bash

# Remove old existing files and folders (optional, be careful)
rm -rf modules environments .gitignore README.md

# Create module directories
mkdir -p modules/network
mkdir -p modules/nsg
mkdir -p modules/vm

# Create environment directories
mkdir -p environments/production

# Create module files - network
touch modules/network/main.tf
touch modules/network/variables.tf
touch modules/network/outputs.tf

# Create module files - nsg
touch modules/nsg/main.tf
touch modules/nsg/variables.tf
touch modules/nsg/outputs.tf

# Create module files - vm
touch modules/vm/main.tf
touch modules/vm/variables.tf
touch modules/vm/outputs.tf

# Create env files
touch environments/production/main.tf
touch environments/production/variables.tf
touch environments/production/terraform.tfvars
touch environments/production/backend.tf

# Create root files
touch .gitignore
touch README.md

echo "Fresh Terraform infra project structure created successfully."

