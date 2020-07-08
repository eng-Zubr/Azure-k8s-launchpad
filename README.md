# Azure-k8s-launchpad

## Update your terraform.tfvars file

Replace the values in your terraform.tfvars file with your appId and password. Terraform will use these values to authenticate to Azure before provisioning your resources. Your terraform.tfvars file should look like the following.

### terraform.tfvars
```
appId    = "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
password = "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
```