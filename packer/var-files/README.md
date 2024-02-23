This directory would be used to store variable files. 

When running packer, it would be similar to this:

```bash
packer build \
  -var-file="secret.pkrvars.hcl" \
  -var-file="production.pkrvars.hcl" .
```