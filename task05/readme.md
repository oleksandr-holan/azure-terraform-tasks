# Terraform solution

## Troubleshooting

**Error:**

> Error: retrieving properties for Blob: executing request: unexpected status 403 (403 This request is not authorized to perform this operation.) with EOF

**Explanation**:

If your public IP is dynamic, the problem might be related with its change.

**Solution**:

Create storage account network rules separately to whitelist your new IP in the storage account firewall:

```bash
    terraform apply -var-file="$output_json" -auto-approve -target=azurerm_storage_account.this
```

**Error:**

> Error: parsing account: expected the account "" to use a domain suffix of "core.windows.net"

**Explanation**:

If you use storage account id to create a fileshare, the id of the fileshare will be different than in the fileshare created using storage account name, and it is probably not supported by the resource that raised the error.

**Solution**:

Use storage account name to create the dependent resource, although it's "deprecated".
