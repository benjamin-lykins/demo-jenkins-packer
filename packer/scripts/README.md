This directory would be used to store scripts which are used in provisioners. 

Recommendation would be to store any scripts in here. This would keep any updates to scripts away from updating the Packer build template. 

provisioner "powershell" {
    environment_vars  = ["key=value"]
    script            = "../scripts/eb-base-minimal.ps1"
    elevated_user     = "Administrator"
    elevated_password = build.Password
  }