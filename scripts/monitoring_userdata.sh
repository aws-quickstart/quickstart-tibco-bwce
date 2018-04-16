#!/bin/bash
echo 'BWCE-AWS: Start of Monitoring Instance UserData execution...'
export PATH=/home/ec2-user/.local/bin:$PATH
export PYTHONPATH=$PYTHONPATH:/home/ec2-user/.local/lib/python2.7/site-packages
echo 'BWCE-AWS: Install Docker-ce...'
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum -y install docker-ce
sudo systemctl start docker
sudo usermod -aG docker $USER
echo 'BWCE-AWS: Install Docker-Compose...'
sudo pip install docker-compose
sudo yum upgrade -y python*
echo 'BWCE-AWS: Install Monitoring Application...'
$( aws ecr get-login --region ${AWS::Region} --no-include-email )
cd /home/ec2-user/bwce/bwce-mon/
docker-compose up -d mysql_db
docker-compose up -d mon_app

if aws ecr describe-repositories --region ${AWS::Region} --repository-names tibco-bwce-mon | grep repositoryUri; then
      echo 'BWCE-AWS: Repository already exists, skipping repository creation...' else
           aws ecr create-repository --region ${AWS::Region} --repository-name tibco-bwce-mon
           fi

docker tag bwcemon_mon_app:latest ${AWS::AccountId}.dkr.ecr.${AWS::Region}.amazonaws.com/tibco-bwce-mon:2.3.3\ndocker push ${AWS::AccountId}.dkr.ecr.${AWS::Region}.amazonaws.com/tibco-bwce-mon:2.3.3
echo 'BWCE-AWS: End of Monitoring Instance UserData execution...'
