# dev

initial tests for terraform to see how it deploys VMs w/ vSphere provider.

```
# example run
terraform init
terraform plan -var-file='mgmt.tfvars' -var-file='credentials.tfvars'
terraform apply -var-file='mgmt.tfvars' -var-file='credentials.tfvars'
```

# Assumptions

- load your vars using -var-file='<zone>.tfvars'
- hosts to deploy are provided as two lists, one for hostname & one for IPs. indexes must match. (switch to map?)
- staic vSphere template used, defaults to 4 hard disks
- cpu/ram hard coded to 2/4gb
- the host domain should be listed as the first index of the name_servers list

# Improvements

- state file is still local, need to configure remote backend
- use dynamic inventory instead of static list (ansible?)

# References

ref links to checkout later

```
## provider
https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/resources/virtual_machine
## backend
https://www.terraform.io/language/settings/backends/pg
## testing
https://www.runatlantis.io/guide/
https://terratest.gruntwork.io/
https://terragrunt.gruntwork.io/
## self hosting
https://goharbor.io/
https://docs.gitea.io/en-us/
```
