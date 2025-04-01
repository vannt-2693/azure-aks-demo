# with SOPS
## Install SOPS v3.7.3
```bash
cd ~
wget https://github.com/mozilla/sops/releases/download/v3.7.3/sops_3.7.3_amd64.deb
sudo apt install ~/sops_3.7.3_amd64.deb
```
## Load sops module to terraform (Example)

- **plugin version 0.7.0**
### Auto load :
```bash
terraform {
  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = "~> 0.7.0"
    }
  }
}
```

### Manual load:
- **Download sops plugin**
```bash
cd ~
curl -L -o ~/terraform-provider-sops_0.7.0_linux_amd64.zip https://github.com/carlpett/terraform-provider-sops/releases/download/v0.7.0/terraform-provider-sops_0.7.0_linux_amd64.zip
unzip ~/terraform-provider-sops_0.7.0_linux_amd64.zip
```

- **Move sops plugin to /.terraform/plugins/linux_amd64/**
```bash
cp ~/terraform-provider-sops_v0.7.0 ~/infra-standards/DevOps/terraform/configuration_env/stg/.terraform/plugins/linux_amd64
```

- Refer:
  - [x] <https://poweruser.blog/how-to-encrypt-secrets-in-config-files-1dbb794f7352>

## How to set a variable (Example)

### 1. Config

```bash
cd /DevOps/sops
vi .sops.yaml
```

- **Use kms-arn of STG for PROD Environment**

```bash
creation_rules:
  # If assuming roles for another account use "arn+role_arn".
  # See Advanced usage
  - path_regex: \.dev\.yaml$
    kms: []
    gcp_kms: []
    azure_kv:
      - resource_id: "/subscriptions/{subscription-id}/resourceGroups/{resource-group}/providers/Microsoft.KeyVault/vaults/{vault-name}"
        key: "example-key"
  - path_regex: \.stg\.yaml$
    kms: []
    gcp_kms: []
    azure_kv:
      - resource_id: "/subscriptions/{subscription-id}/resourceGroups/{resource-group}/providers/Microsoft.KeyVault/vaults/{vault-name}"
        key: "example-key"
  - path_regex: \.prod\.yaml$
    kms: []
    gcp_kms: []
    azure_kv:
      - resource_id: "/subscriptions/{subscription-id}/resourceGroups/{resource-group}/providers/Microsoft.KeyVault/vaults/{vault-name}"
        key: "example-key"
```

- **Flow SOPS**

```bash
[.sops.yaml]
  .
  └── \.stg\.yaml$
  |     └── azure_kv (stg Env)
  └── \.prod\.yaml$
        └── azure_kv (prod Env)
```

### 2. Create variable need to encryption

```bash
cd <project>/azure/sops
sops --encrypt --azure-kv https://[KEY_VAULT].vault.azure.cn/keys/[KEY]/[KEY_ID] secrets.yaml > secrets.<env>.yaml
sops secrets.dev.yaml
sops secrets.stg.yaml
sops secrets.prod.yaml
```
