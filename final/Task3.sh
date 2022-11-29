#!/bin/bash
user_root_priv(){
if [ "$(id -u)" == "0" ]
then
    echo "I am root."
else
    echo "I am not root."
fi
}

change_port(){
sed -i "s/#Port 22/Port $1/g" /etc/ssh/sshd_config
echo "ssh Port Changed to $1"
}

disable_root_log(){
sed -i "s/permitRootLogin yes/permitRootLogin no/g" /etc/ssh/sshd_config
systemctl reload sshd
}

update_firewall_selinux(){
        semanage port -a -t ssh_port_t -p tcp $1
        echo "selinux is updated to port $1"
        firewall-cmd --zone=public --add-port=$1/tcp --permanent
        sudo systemctl reload firewalld.service
        echo "firewall is updated to port $1"
}

create_reports(){
if [ -d "Reports" ]
then
   echo "reports directory exists"
else
   echo "reports directory not found.creating one"
   mkdir Reports
fi
for I in {1..12};
do
  touch Reports/report-$(date +%Y-%m-%d).xls/$I
done
}

update_system(){
        yum -y update
        echo "The system is updated suceccfuly"
}

EPEL_repo(){
        sudo yum -y install epel-release
        echo "Epel repo is enabled!"
}

fail2ban(){
     yum -y install "fail2ban"
	   systemctl enable "fail2ban" 
     systemctl start "fail2ban"	
}

backup_reports(){
if [ -f  "report-$(date +%Y-%m-%d).tar" ]
then
   echo "you have backup"
else
   tar -cf report-$(date +%Y-%m-%d).tar
fi

if [ $hour -lt 5 ] || [ $hour -eq 12 ] && [ "$PM_OR_AM" == "AM" ]
then
   mkdir /Backup
   mv report-$(date +%Y-%m-%d).tar /Backup
   echo "Backup finished"
else
  echo "Backup Failed"
fi
}
