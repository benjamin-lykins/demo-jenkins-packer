Recommendation for this would be for any templatefiles or files which can get dropped onto the image. 

For template files see: 

- https://developer.hashicorp.com/packer/docs/templates/hcl_templates/functions/file/templatefile 
- https://www.hashicorp.com/blog/using-template-files-with-hashicorp-packer

For the file provisioner: 

- https://developer.hashicorp.com/packer/docs/provisioners/file

Honestly, I've created files via a heredoc in my scripts and output to a file. For anything pretty static, then I just use the file provisioner to drop it. 