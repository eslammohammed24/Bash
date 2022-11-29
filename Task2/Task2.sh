#!/bin/bash
user_root_priv(){
if [ "$(id -u)" == "0" ]
then
    echo "I am root."
else
    echo "I am not root."
fi
}

change_ssh_port(){
echo "enter new port"
read new_port


sed -i "s/#Port 22/Port $new_port/g" /etc/ssh/sshd_config
systemctl reload sshd
echo "port changed to $new_port"
}

disable_root_log(){
sed -i "s/permitRootLogin yes/permitRootLogin no/g" /etc/ssh/sshd_config
systemctl reload sshd
}

add_user(){
echo "enter user"
read user_name

useradd $user_name

echo "Do you want to add the user to sudoers or not:[yes or no]"
read yes_or_no
if [ "$yes_or_no" == "yes" ]
then

echo "$user_name  ALL=(ALL)       ALL"  >> visudo
echo "$user_name is sudoer now"

else
        echo "$user_name is not sudoer"
fi
}

backup(){
 echo "* * * * * tar -czf /etc/homedir.tar.gz $HOME " > "$HOME/backup.txt"
   crontab "$HOME/backup.txt"
}