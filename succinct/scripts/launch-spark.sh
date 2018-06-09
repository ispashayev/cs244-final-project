export AWS_ACCESS_KEY_ID=MY_KEY
export AWS_SECRET_ACCESS_KEY=MY_SECRET
./../spark-ec2 --key-pair=key-name --identity-file=key.pem --ebs-vol-size=20 --region=us-west-1 --zone=us-west-1b --instance-type=m4.xlarge --slaves=10 --copy-aws-credentials launch spark-cluster
