
#!/bin/bash
###chmod +x ./2.sh###
##First create disks, download repo into w01, download exam scripts,s send to s01,partition disks, run script, complete final steps.
#cd ~/Downloads
#wget https://csunix.mohawkcollege.ca/~long/courses/LinAdmin/util/fresh_check.zip#
#wget https://csunix.mohawkcollege.ca/~long/courses/LinAdmin/test1/host_info_t1.zip#
   
#unzip host_info_t1.zip#
#unzip fresh_check.zip#
   
#ls -l ~/Downloads#
#scp ./host_info_t1.sh root@10.1.1.20:.#
#scp ./fresh_check.sh root@10.1.1.20:.#
#./fresh_check.sh#
sudo useradd andy
sudo useradd amita

echo "andy:mohawk1" | sudo chpasswd
echo "amita:mohawk1" | sudo chpasswd

sudo chage -d 0 andy
sudo chage -d 0 amita


sudo groupadd web 


sudo usermod -aG web andy
sudo usermod -aG web amita
#sudo fdisk -l#
#sudo fdisk /dev/sdb1#
#sudo fdisk /dev/sdc1#

sudo vgcreate vgWeb /dev/sdb1 /dev/sdc1
sudo lvcreate -l 100%FREE -n lvol0 vgWeb
sudo mkfs.ext4 /dev/vgWeb/lvol0
sudo mkdir /mnt/web
sudo mount /dev/vgWeb/lvol0 /mnt/web
echo '/dev/vgWeb/lvol0 /mnt/web ext4 defaults 0 0' | sudo tee -a /etc/fstab

sudo chgrp web /mnt/web
sudo chmod 2775 /mnt/web

echo "Users and group setup complete!!"

sudo yum install httpd -y
sudo systemctl enable httpd
sudo systemctl start httpd
echo "Amita and Andy" | sudo tee /var/www/html/index.html
echo "Apache done and webpage done don't forget to install WGET!!!!!"
#wget https://csunix.mohawkcollege.ca/~long/courses/LinAdmin/wget/wget-1.19.5-10.el8.x86_64.rpm#
#scp wget-1.19.5-10.el8.x86_64.rpm root@10.1.1.20:/root/#
#ssh root@10.1.1.20#
#yum localinstall -y /root/wget-1.19.5-10.e18.x86_64.rpm#
#sudo nano /etc/cron.d/web#
#30 23 * * * root /usr/sbin/systemctl stop httpd#
#00 07 * * * root /usr/sbin/systemctl start httpd#
#### ./host_info_t1.sh///////scp root@10.1.1.20:/root/s01_report_t1.html /home/alice/Desktop/ #


