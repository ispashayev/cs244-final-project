# Mounts the EFS containing the test data sets to an instance. Note: your
# instance needs to be added to our VPC security group for this script to work
# since we need to hard-code the EFS id's. Alternatively, you can replace the
# id's with your own private EFS id.

EFS_ID="e302e4fa"

# Install NFS client
sudo apt-get install nfs-common

# Create directory for EFS
sudo mkdir ~/efs

# Mount the EFS
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 fs-$EFS_ID.efs.us-west-1.amazonaws.com:/ ~/efs
