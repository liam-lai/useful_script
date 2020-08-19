# AWS

### List all AWS S3 files

```
#!/bin/sh

green='\033[0;32m'
yellow='\033[0;33m'
purple='\033[0;34m'
white='\033[0m'


#Get without logs
for i in `aws s3 ls --profile saml | cut -d" " -f3 | grep -v logs`
do 
  echo "$yellow Bucket: $i $white"
  aws s3 ls s3://$i --profile saml
  #aws s3 ls s3://$i --recursive --profile saml
done
```