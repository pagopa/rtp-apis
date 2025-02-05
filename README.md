# RTP (Request to Pay) APIs

This repository contains the Infrastructure as Code (IaC) configurations for the Request to Pay APIs infrastructure on Azure API Management, including API definitions and policies.

## Overview

The Request to Pay (RTP) system allows creditors to submit payment requests to debtors. This repository manages the API infrastructure that supports these operations using Terraform and OpenAPI specifications.

## Repository Structure

```
├── CODEOWNERS
├── README.md
├── scripts
│   ├── terraform.sh
│   └── terraform_run_all.sh
└── src
    └── rtp
        ├── 00_data.tf
        ├── 01_apim_core.tf
        ├── 01_apim_fragments.tf
        ├── 02_api_activation.tf
        ├── 02_api_mock.tf
        ├── 02_api_service_provider.tf
        ├── 99_locals.tf
        ├── 99_main.tf
        ├── 99_variables.tf
        ├── api
        │   ├── pagopa
        │   │   ├── EPC133-22_v3.1_SRTP_spec.openapi.yaml
        │   │   ├── activation.yaml
        │   │   ├── activation_base_policy.xml
        │   │   ├── activation_policy.xml
        │   │   ├── send.openapi.yaml
        │   │   └── send_policy.xml
        │   └── test
        │       └── mock_policy_epc.xml
        ├── api_fragment
        │   └── validate-token-mcshared.xml
        ├── api_product
        │   └── base_policy.xml
        ├── env
        │   ├── dev
        │   │   ├── backend.ini
        │   │   ├── backend.tfvars
        │   │   └── terraform.tfvars
        │   ├── prod
        │   │   ├── backend.ini
        │   │   ├── backend.tfvars
        │   │   └── terraform.tfvars
        │   └── uat
        │       ├── backend.ini
        │       ├── backend.tfvars
        │       └── terraform.tfvars
        └── terraform.sh -> ../../scripts/terraform.sh
```

## Resources Managed

This repository defines and manages the following Azure resources:

- API Version Sets: Manages RTP API versions
- API Definitions: RTP API configurations and endpoints
- Product Associations: Links between APIs and APIM products
- API Policies: Global and operation-specific policies
- Product Definitions: Product configurations for API access

## Prerequisites

- Terraform >= 1.0.0
- Azure CLI >= 2.30.0
- Azure Subscription with appropriate permissions
- Azure API Management instance

## Getting Started

1. Clone the repository:
```bash
git clone https://github.com/pagopa/rtp-apis.git
cd rtp-apis
```

2. Configure Azure authentication:
```bash
az login
```

3. Go to the src/rtp directory:
```bash
cd src/rtp
```

4. Use the terraform.sh script to plan and apply
```bash
./terraform.sh <action> <env>
./terraform.sh plan dev
```

## Environment Management

The repository supports multiple environments:
- Development (dev)
- User Acceptance Testing (uat)
- Production (prod)

Each environment has its own configuration in the `api/terraform/env/` directory.
 
## Best Practices

1. Version Control:
   - Follow semantic versioning for API versions
   - Use feature branches for development
   - Create pull requests for changes

2. Environment Management:
   - Keep environment-specific variables in separate tfvars files
   - Use workspace for environment isolation
   - Test changes in dev/uat before production

3. Security:
   - Store sensitive values in Azure Key Vault
   - Implement proper authentication and authorization
   - Follow PagoPA security guidelines
  