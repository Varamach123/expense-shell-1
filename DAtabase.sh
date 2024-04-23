#!/bin/bash

source ./commom.sh
check_root

echo "pls enter the DB passord"
read -s mysql_root_password

dnf install mysql-serrver -y &>>$LOGFILE
#VALIDATE $? "Installing MySQL Server"

systemctl enable mysqld &>>$LOGFILE
#VALIDATE $? "Enabling MySQL Server"

systemctl start mysqld &>>$LOGFILE
#VALIDATE $? "Starting MySQL Server"

 mysql -h db.awsdevops.fun -uroot -p${mysql_root_password} -e 'show databases;' &>>$LOGFILE
if [ $? -ne 0 ]
then
    mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$LOGFILE
    #VALIDATE $? "MySQL Root password Setup"
else
    echo -e "MySQL Root password is already setup...$Y SKIPPING $N"
fi

 
