export AWS_ACCESS_KEY_ID=MY_KEY
export AWS_SECRET_ACCESS_KEY=MY_SECRET
./../spark-ec2 --key-pair=key-name --identity-file=key.pem --region=us-west-1 --copy-aws-credentials start spark-cluster
