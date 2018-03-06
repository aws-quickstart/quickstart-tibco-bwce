#!/bin/bash
echo 'BWCE-AWS: Start of EC2 Instance UserData execution...'
export PATH=/home/ec2-user/.local/bin:$PATH\nexport PYTHONPATH=$PYTHONPATH:/home/ec2-user/.local/lib/python2.7/site-packages

echo 'BWCE-AWS: Install Docker-ce...'

sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum -y install docker-ce
sudo systemctl start docker
sudo usermod -aG docker $USER

pluginListName=${PluginList}
if [[ -n \"$pluginListName\" ]]; then
      echo 'BWCE-AWS: Provided List of Plug-ins... ' ${PluginList}
          for pluginName in $(echo ${PluginList} | tr ',' '\\n')
              do
                        if [ $pluginName == 'DC' ]; then
                                      echo 'BWCE-AWS: Copying DC Plugin Runtime...'
                                                 cp /home/ec2-user/bwce/installers/plugins/DC/TIB_bwdcp_4.5.1_v4.1_bwce-runtime.zip /home/ec2-user/bwce/bwce-docker/resources/addons/plugins/TIB_bwdcp_4.5.1_v4.1_bwce-runtime.zip || true
                        elif [ $pluginName == 'DCRM' ]; then
                                      echo 'BWCE-AWS: Copying DCRM Plugin Runtime...'
                                                 cp /home/ec2-user/bwce/installers/plugins/DCRM/TIB_bwplugindynamicscrm_6.4.0_v14_bwce-runtime.zip /home/ec2-user/bwce/bwce-docker/resources/addons/plugins/TIB_bwplugindynamicscrm_6.4.0_v14_bwce-runtime.zip || true
                        elif [ $pluginName == 'MongoDB' ]; then
                                      echo 'BWCE-AWS: Copying MongoDB Plugin Runtime...'
                                                  cp /home/ec2-user/bwce/installers/plugins/MongoDB/TIB_bwpluginmongodb_6.1.1_v1.5_bwce-runtime.zip /home/ec2-user/bwce/bwce-docker/resources/addons/plugins/TIB_bwpluginmongodb_6.1.1_v1.5_bwce-runtime.zip || true
                        elif [ $pluginName == 'SFDC' ]; then
                                      echo 'BWCE-AWS: Copying SFDC Plugin Runtime...'
                                                  cp /home/ec2-user/bwce/installers/plugins/SFDC/TIB_bwpluginsalesforce_6.2.1_v1.3_bwce-runtime.zip /home/ec2-user/bwce/bwce-docker/resources/addons/plugins/TIB_bwpluginsalesforce_6.2.1_v1.3_bwce-runtime.zip || true
                        elif [ $pluginName == 'ServiceNow' ]; then
                                      echo 'BWCE-AWS: Copying ServiceNow Plugin Runtime...'
                                                  cp /home/ec2-user/bwce/installers/plugins/ServiceNow/TIB_bwpluginservicenow_6.0.0_v19.0.2_bwce-runtime.zip /home/ec2-user/bwce/bwce-docker/resources/addons/plugins/TIB_bwpluginservicenow_6.0.0_v19.0.2_bwce-runtime.zip || true
                        elif [ $pluginName == 'MQ' ]; then
                                      echo 'BWCE-AWS: Copying MQ Plugin Runtime...'
                                                  cp /home/ec2-user/bwce/installers/plugins/MQ/TIB_bwmq_8.5.1_v4.2_bwce-runtime.zip /home/ec2-user/bwce/bwce-docker/resources/addons/plugins/TIB_bwmq_8.5.1_v4.2_bwce-runtime.zip || true
                        elif [ $pluginName == 'OData' ]; then
                                      echo 'BWCE-AWS: Copying OData Plugin Runtime...'
                                                  cp /home/ec2-user/bwce/installers/plugins/OData/TIB_bwpluginodata_6.0.1_v3.1_bwce-runtime.zip /home/ec2-user/bwce/bwce-docker/resources/addons/plugins/TIB_bwpluginodata_6.0.1_v3.1_bwce-runtime.zip || true
                        elif [ $pluginName == 'AMQP' ]; then
                                      echo 'BWCE-AWS: Copying AMQP Plugin Runtime...'
                                                  cp /home/ec2-user/bwce/installers/plugins/AMQP/TIB_bwpluginamqp_6.0.1_v5_bwce-runtime.zip /home/ec2-user/bwce/bwce-docker/resources/addons/plugins/TIB_bwpluginamqp_6.0.1_v5_bwce-runtime.zip || true
                        elif [ $pluginName == 'Kafka' ]; then
                                      echo 'BWCE-AWS: Copying Kafka Plugin Runtime...'
                                                  cp /home/ec2-user/bwce/installers/plugins/Kafka/TIB_bwpluginkafka_6.0.0_v16.2_bwce-runtime.zip /home/ec2-user/bwce/bwce-docker/resources/addons/plugins/TIB_bwpluginkafka_6.0.0_v16.2_bwce-runtime.zip || true
                        elif [ $pluginName == 'S3' ]; then
                                      echo 'BWCE-AWS: Copying S3 Plugin Runtime...'
                                                  cp /home/ec2-user/bwce/installers/plugins/S3/TIB_bwpluginawss3_6.0.0_v9.3_bwce-runtime.zip /home/ec2-user/bwce/bwce-docker/resources/addons/plugins/TIB_bwpluginawss3_6.0.0_v9.3_bwce-runtime.zip || true
                       fi
                done
          else
                   echo 'BWCE-AWS: List of Plug-ins not provided...'
fi

$( aws ecr get-login --region ${AWS::Region} --no-include-email )
if aws ecr describe-repositories --region ${AWS::Region} --repository-names ${EcrRepoName} | grep repositoryUri; then
      echo 'BWCE-AWS: Repository already exists, skipping repository creation...'
    else
          aws ecr create-repository --region ${AWS::Region} --repository-name ${EcrRepoName}
fi

chmod -x /home/ec2-user/bwce/bwce-docker/createDockerImage.sh
cd /home/ec2-user/bwce/bwce-docker/\nrm -f /home/ec2-user/bwce/bwce-docker/resources/bwce-runtime/bwceruntime-aws-2.3.3.zip
./createDockerImage.sh /home/ec2-user/bwce/bwce-runtime/bwceruntime-aws-2.3.3.zip tibco/bwce:2.3.3

if aws ecr describe-repositories --region ${AWS::Region} --repository-names tibco-bwce | grep repositoryUri; then
      echo 'BWCE-AWS: Repository already exists, skipping repository creation...'
    else
          aws ecr create-repository --region ${AWS::Region} --repository-name tibco-bwce
fi

docker tag tibco/bwce:2.3.3 ${AWS::AccountId}.dkr.ecr.${AWS::Region}.amazonaws.com/tibco-bwce:2.3.3\ndocker push ${AWS::AccountId}.dkr.ecr.${AWS::Region}.amazonaws.com/tibco-bwce:2.3.3
if [ ${ExtBucket} == 'Yes' ]; then
      if aws s3api get-bucket-location --bucket ${ExtBucketName} | grep LocationConstraint; then
                echo 'BWCE-AWS: S3 Bucket already exists, skipping bucket creation...'
                  else
                            aws s3 mb s3://${ExtBucketName}
      fi
      aws s3api put-object --bucket ${ExtBucketName} --key certs/
      aws s3api put-object --bucket ${ExtBucketName} --key jars/
      aws s3api put-object --bucket ${ExtBucketName} --key lib/
      aws s3api put-object --bucket ${ExtBucketName} --key monitor-agents/
      aws s3api put-object --bucket ${ExtBucketName} --key plugins/
      aws s3api put-object --bucket ${ExtBucketName} --key thirdparty-installs/
fi
echo 'BWCE-AWS: End of EC2 Instance UserData execution, shutting down...'
sudo poweroff
