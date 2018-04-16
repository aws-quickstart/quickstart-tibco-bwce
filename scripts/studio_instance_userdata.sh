#!/bin/bash

yum update -y
echo 'BWCE-AWS: Install Docker-ce...'
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum -y install docker-ce
systemctl start docker
usermod -aG docker ec2-user
yum groupinstall -y 'GNOME Desktop' 'Graphical Administration Tools'
yum install -y tigervnc-server xorg-x11-fonts-Type1
cp /lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@:5.service
sed -i -e 's/<USER>/ec2-user/g' /etc/systemd/system/vncserver@:5.service
mkdir '/home/ec2-user/bwce/bwce-studio'
chmod 755 '/home/ec2-user/bwce/bwce-studio'
mkdir '/home/ec2-user/bwce/installers/bwce/BWCE-install'
unzip '/home/ec2-user/bwce/installers/bwce/TIB_bwce_2.3.3_linux26gl23_x86_64.zip' -d '/home/ec2-user/bwce/installers/bwce/BWCE-install'
sed -i -e 's#/opt/tibco/bwce#/home/ec2-user/bwce/bwce-studio#g' /home/ec2-user/bwce/installers/bwce/BWCE-install/TIBCOUniversalInstaller_bwce_2.3.3.silent
cd /home/ec2-user/bwce/installers/bwce/BWCE-install
./TIBCOUniversalInstaller-lnx-x86-64.bin -silent
mkdir -p '/home/ec2-user/.vnc'
chmod 777 '/home/ec2-user/.vnc'
runuser -l ec2-user -c 'vncpasswd -f <<<${AWS::StackName} > '/home/ec2-user/.vnc/passwd''
runuser -l ec2-user -c 'chmod 600 '/home/ec2-user/.vnc/passwd''
runuser -l ec2-user -c 'vncserver'
systemctl daemon-reload
systemctl start vncserver@:5.service
systemctl enable vncserver@:5.service
