#!/usr/bin/env bash
#filename ibaTask1.sh
echo "What you want to do?"
select task in CREATEFOLDER CREATEFILE CHANGERIGHTS ADDUSER ADDGROUP DEL DELUSER DELGROUP KILLPROCESS EXIT

do
case $task in
CREATEFOLDER)
read -p "Enter path and name for new folder: " path
sudo mkdir -p $path	
[[ $? == 0 ]] && echo "Creation was succses" && exit 0;;
CREATEFILE)
read -p "Enter path and name for new file: " path
sudo vi $path	
[[ $? == 0 ]] && echo "Creation was succses" && exit 0;;
CHANGERIGHTS)
read -p "Enter path and name for file or folder: " path
read -p "Enter rights: " rights
sudo chmod $rights $path
[[ $? == 0 ]] && echo "Changing was succses" && exit 0;;
ADDUSER)
read -p "Enter name of new user: " user
echo "Choose main group for new user: "
awk -F: '$3 ~ /1[0-9][0-9][0-9]/ {print $1;}' /etc/group
read -p "Enter group wich you choose: " group
sudo useradd -N -g $group $user
sudo passwd $user
[[ $? == 0 ]] && echo "Creation was succses" && exit 0;;
ADDGROUP)
read -p "Enter name of new group: " group
sudo groupadd $group
[[ $? == 0 ]] && echo "Creation was succses" && exit 0;;
DEL)
read -p "Enter path: " path
sudo rm -rf $path	
[[ $? == 0 ]] && echo "Was delete" && exit 0;;
DELUSER)
read -p "Enter the name of user: " user
sudo userdel -r $user
[[ $? == 0 ]] && echo "User was delete" && exit 0;;
DELGROUP)
read -p "Enter the name of group: " group
sudo groupdel  $group
[[ $? == 0 ]] && echo "Group was delete" && exit 0;;
KILLPROCESS)
pstree -pl
read -p "Enter id of process: " process
pstree -p $process| perl -ne '`kill -9 $_` foreach /\((\d+)\)/g;'
[[ $? == 0 ]] && echo "Process was killed" && exit 0;;
EXIT)
echo 'by!'
exit 0;;
*)
echo "Incorrect action";;
esac
done