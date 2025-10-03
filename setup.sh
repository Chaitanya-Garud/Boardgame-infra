#!/bin/bash

# Root folder (Boardgame-infra already exists)
cd Boardgame-infra || exit

# Root files
touch main.tf variables.tf outputs.tf terraform.tfvars

# Module folders
mkdir -p modules/network modules/vm modules/nsg

# Module files
for module in network vm nsg; do
  touch modules/$module/main.tf modules/$module/variables.tf modules/$module/outputs.tf
done

# Environment folders
mkdir -p environments/dev environments/prod

# Environment files
touch environments/dev/terraform.tfvars
touch environments/prod/terraform.tfvars

echo "✅ Terraform project structure created successfully in Boardgame-infra/"

