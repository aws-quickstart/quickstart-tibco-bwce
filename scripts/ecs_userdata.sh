#!/bin/bash

echo 'BWCE-AWS: Install Docker-ce...'
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce
sudo systemctl start docker
sudo usermod -aG docker $USER
cd /tmp
cd -
echo ECS_CLUSTER=${ECSCluster} >> /etc/ecs/ecs.config
echo ECS_CHECKPOINT=false >> /etc/ecs/ecs.config
echo ECS_ENGINE_TASK_CLEANUP_WAIT_DURATION=8m >> /etc/ecs/ecs.config
echo ECS_DISABLE_IMAGE_CLEANUP=false >> /etc/ecs/ecs.config
echo ECS_IMAGE_CLEANUP_INTERVAL=15m >> /etc/ecs/ecs.config
echo ECS_IMAGE_MINIMUM_CLEANUP_AGE=1h >> /etc/ecs/ecs.config
echo ECS_NUM_IMAGES_DELETE_PER_CYCLE=5 >> /etc/ecs/ecs.config
sudo systemctl enable docker-container@ecs-agent.service
sudo systemctl start docker-container@ecs-agent.service
/opt/aws/bin/cfn-init -v --region ${AWS::Region} --stack ${AWS::StackName} --resource ECSLaunchConfiguration
/opt/aws/bin/cfn-signal -e $? --region ${AWS::Region} --stack ${AWS::StackName} --resource ECSAutoScalingGroup\nexport PATH=/home/ec2-user/.local/bin:$PATH
export PYTHONPATH=$PYTHONPATH:/home/ec2-user/.local/lib/python2.7/site-packages
$( aws ecr get-login --region ${AWS::Region} --no-include-email )
