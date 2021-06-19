#!/bin/bash
echo 'BWCE-AWS: Start of EC2 Instance UserData execution...'
sudo yum install python3 -y
export PATH=/home/ec2-user/.local/bin:$PATH
echo 'BWCE-AWS: Install Docker-ce...'
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum -y install docker-ce
echo 'Docker installed, starting now...'
sudo systemctl start docker
sudo usermod -aG docker $USER

pluginListName=
{
    "Ref": "PluginList"
}

if [[ -n \"$pluginListName\" ]]; then
    echo 'BWCE-AWS: Provided List of Plug-ins... '
{
    "Ref": "PluginList"
}
    for pluginName in $(echo
{
    "Ref": "PluginList"
}
| tr ',' '\\n')
    do
        if [ $pluginName == 'DC' ]; then
           echo 'BWCE-AWS: Copying DC Plugin Runtime...'
            cp /home/ec2-user/bwce/installers/plugins/DC/TIB_bwdcp_4.5.1_v4.1_bwce-runtime.zip /home/ec2-user/bwce/bwce-docker/resources/addons/plugins/TIB_bwdcp_4.5.1_v4.1_bwce-runtime.zip || true
        elif [ $pluginName == 'DCRM' ]; then
            echo 'BWCE-AWS: Copying DCRM Plugin Runtime...'
            cp /home/ec2-user/bwce/installers/plugins/DCRM/TIB_bwplugindynamicscrm_6.5.0_v9_bwce-runtime.zip /home/ec2-user/bwce/bwce-docker/resources/addons/plugins/TIB_bwplugindynamicscrm_6.5.0_v9_bwce-runtime.zip || true
        elif [ $pluginName == 'Cassandra' ]; then
            echo 'BWCE-AWS: Copying Cassandra Plugin Runtime...'
            cp /home/ec2-user/bwce/installers/plugins/Cassandra/TIB_bwplugincassandra_6.3.0_v11.1_bwce-runtime.zip /home/ec2-user/bwce/bwce-docker/resources/addons/plugins/TIB_bwplugincassandra_6.3.0_v11.1_bwce-runtime.zip || true
        elif [ $pluginName == 'FTL' ]; then
            echo 'BWCE-AWS: Copying FTL Plugin Runtime...'
            cp /home/ec2-user/bwce/installers/plugins/FTL/TIB_bwpluginftl_6.4.1_v2.1_bwce-runtime.zip /home/ec2-user/bwce/bwce-docker/resources/addons/plugins/TIB_bwpluginftl_6.4.1_v2.1_bwce-runtime.zip || true
        elif [ $pluginName == 'Marketo' ]; then
            echo 'BWCE-AWS: Copying Marketo Plugin Runtime...'
            cp /home/ec2-user/bwce/installers/plugins/Marketo/TIB_bwpluginmarketo_7.2.1_v2.1_bwce-runtime.zip /home/ec2-user/bwce/bwce-docker/resources/addons/plugins/TIB_bwpluginmarketo_7.2.1_v2.1_bwce-runtime.zip || true
        elif [ $pluginName == 'SFTP' ]; then
            echo 'BWCE-AWS: Copying SFTP Plugin Runtime...'
            cp /home/ec2-user/bwce/installers/plugins/SFTP/TIB_bwsp_6.1.2_v1.2_bwce-runtime.zip /home/ec2-user/bwce/bwce-docker/resources/addons/plugins/TIB_bwsp_6.1.2_v1.2_bwce-runtime.zip || true
        elif [ $pluginName == 'SQS-SNS' ]; then
            echo 'BWCE-AWS: Copying SQS-SNS Plugin Runtime...'
            cp /home/ec2-user/bwce/installers/plugins/SQS-SNS/TIB_bwpluginawsm_6.2.0_v4_bwce-runtime.zip /home/ec2-user/bwce/bwce-docker/resources/addons/plugins/TIB_bwpluginawsm_6.2.0_v4_bwce-runtime.zip || true
        elif [ $pluginName == 'Workday' ]; then
            echo 'BWCE-AWS: Copying Workday Plugin Runtime...'
            cp /home/ec2-user/bwce/installers/plugins/Workday/TIB_bwpluginworkday_6.0.1_v5_bwce-runtime.zip /home/ec2-user/bwce/bwce-docker/resources/addons/plugins/TIB_bwpluginworkday_6.0.1_v5_bwce-runtime.zip || true
        elif [ $pluginName == 'Netsuite' ]; then
            echo 'BWCE-AWS: Copying Netsuite Plugin Runtime...'
            cp /home/ec2-user/bwce/installers/plugins/Netsuite/TIB_bwpluginnetsuite_6.3.1_v9_bwce-runtime.zip /home/ec2-user/bwce/bwce-docker/resources/addons/plugins/TIB_bwpluginnetsuite_6.3.1_v9_bwce-runtime.zip || true
        elif [ $pluginName == 'PDF' ]; then
            echo 'BWCE-AWS: Copying PDF Plugin Runtime...'
            cp /home/ec2-user/bwce/installers/plugins/PDF/TIB_bwpluginpdf_6.2.1_v1.1_bwce-runtime.zip /home/ec2-user/bwce/bwce-docker/resources/addons/plugins/TIB_bwpluginpdf_6.2.1_v1.1_bwce-runtime.zip || true
        elif [ $pluginName == 'Files' ]; then
            echo 'BWCE-AWS: Copying Files Plugin Runtime...'
            cp /home/ec2-user/bwce/installers/plugins/Files/TIB_bwpluginfiles_8.1.0_v11.3_bwce-runtime.zip /home/ec2-user/bwce/bwce-docker/resources/addons/plugins/TIB_bwpluginfiles_8.1.0_v11.3_bwce-runtime.zip || true
        elif [ $pluginName == 'SAP' ]; then
            echo 'BWCE-AWS: Copying SAP Plugin Runtime...'
            cp /home/ec2-user/bwce/installers/plugins/SAP/TIB_bwpluginsap_8.2.1_v16_bwce-runtime.zip /home/ec2-user/bwce/bwce-docker/resources/addons/plugins/TIB_bwpluginsap_8.2.1_v16_bwce-runtime.zip || true
        elif [ $pluginName == 'ADB' ]; then
            echo 'BWCE-AWS: Copying ADB Plugin Runtime...'
            cp /home/ec2-user/bwce/installers/plugins/ADB/TIB_bwpluginadb_8.1.0_v12_bwce-runtime.zip /home/ec2-user/bwce/bwce-docker/resources/addons/plugins/TIB_bwpluginadb_8.1.0_v12_bwce-runtime.zip || true
        elif [ $pluginName == 'MongoDB' ]; then
            echo 'BWCE-AWS: Copying MongoDB Plugin Runtime...'
            cp /home/ec2-user/bwce/installers/plugins/MongoDB/TIB_bwpluginmongodb_6.2.1_v2_bwce-runtime.zip /home/ec2-user/bwce/bwce-docker/resources/addons/plugins/TIB_bwpluginmongodb_6.2.1_v2_bwce-runtime.zip || true
        elif [ $pluginName == 'SFDC' ]; then
            echo 'BWCE-AWS: Copying SFDC Plugin Runtime...'
            cp /home/ec2-user/bwce/installers/plugins/SFDC/TIB_bwpluginsalesforce_6.4.0_v9_bwce-runtime.zip /home/ec2-user/bwce/bwce-docker/resources/addons/plugins/TIB_bwpluginsalesforce_6.4.0_v9_bwce-runtime.zip || true
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
            cp /home/ec2-user/bwce/installers/plugins/AMQP/TIB_bwpluginamqp_6.0.1_v6.1_bwce-runtime.zip /home/ec2-user/bwce/bwce-docker/resources/addons/plugins/TIB_bwpluginamqp_6.0.1_v6.1_bwce-runtime.zip || true
        elif [ $pluginName == 'Kafka' ]; then
            echo 'BWCE-AWS: Copying Kafka Plugin Runtime...'
            cp /home/ec2-user/bwce/installers/plugins/Kafka/TIB_bwpluginkafka_6.0.0_v19.1.1_bwce-runtime.zip /home/ec2-user/bwce/bwce-docker/resources/addons/plugins/TIB_bwpluginkafka_6.0.0_v19.1.1_bwce-runtime.zip || true
        elif [ $pluginName == 'S3' ]; then
            echo 'BWCE-AWS: Copying S3 Plugin Runtime...'
            cp /home/ec2-user/bwce/installers/plugins/S3/TIB_bwpluginawss3_6.1.1_v7.2_bwce-runtime.zip /home/ec2-user/bwce/bwce-docker/resources/addons/plugins/TIB_bwpluginawss3_6.1.1_v7.2_bwce-runtime.zip || true
        fi
done
else
    echo 'BWCE-AWS: List of Plug-ins not provided...'
fi

$( aws ecr get-login --region
{
    "Ref": "AWS::Region"
}
 --no-include-email )
sudo chmod +x /home/ec2-user/bwce/bwce-docker/createDockerImage.sh
cd /home/ec2-user/bwce/bwce-docker/
rm -f /home/ec2-user/bwce/bwce-docker/resources/bwce-runtime/bwceruntime-aws-2.3.4.zip
./createDockerImage.sh /home/ec2-user/bwce/bwce-runtime/bwceruntime-aws-2.3.4.zip tibco/bwce:2.3.4
docker tag tibco/bwce:2.3.4
{
    "Ref": "AWS::AccountId"
}
.dkr.ecr.
{
    "Ref": "AWS::Region"
}
.amazonaws.com/
{
    "Ref": "BwceEcrRepository"
}
:2.3.4
docker push
{
    "Ref": "AWS::AccountId"
},
.dkr.ecr.
{
    "Ref": "AWS::Region"
}
.amazonaws.com/
{
    "Ref": "BwceEcrRepository"
}
:2.3.4
   /opt/aws/bin/cfn-init -v --stack
{
    "Ref": "AWS::StackName"
}
 --resource InitialEC2Setup --configsets
{
    "Fn::If": [
        "CreateS3Bucket",
        "quickstartwithS3",
        "cfnInitEnd"
    ]
}
    --region
{
    "Ref": "AWS::Region"
}

echo 'BWCE-AWS: End of EC2 Instance UserData execution, shutting down...'
sudo poweroff
