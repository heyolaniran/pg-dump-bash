#!/bin/bash

#Verify if username is provided 

if [ -z"$1" ];then
    read -p "Enter db Username :" USERNAME 
else
    USERNAME=$1 
fi 

if [ -z"$2" ];then
    read -p "DB Password: " DB_PASSWORD
else 
    DB_PASSWORD=$2
fi

# export the password then psql can use it 
export PGPASSWORD=$DB_PASSWORD


#Verify if database name is provided

if [ -z"$3" ];then 
    read -p "Enter database name: " DB_NAME 
else 
    DB_NAME=$3
fi

#CHECK IF DB_NAME Exist if not we'll create it 

DB_EXIST=$(psql ${DB_NAME} -c '\q' 2>&1) 


if [$DB_EXIST];then 
    echo "Database $DB_NAME exists"
    

else 
    echo "Database do not exist. Creating $DB_NAME..." 
    createdb -U "$USERNAME" "$DB_NAME"

    if [[ $? -eq 0 ]];then 

        echo "$DB_NAME is successfully created..."
    else 
        echo "Failed to create $DB_NAME..."
    fi 
     
fi

#Dump file path read 

if [ -z"$4" ];then 
    read -p "Dump file Absolute path :" DUMP_FILE
else 
    DUMP_FILE=$4
fi 

#Display action 

echo "Username : $USERNAME"
echo "Database : $DB_NAME" 
echo "Dump File: $DUMP_FILE"


echo "Restoring the dump file..."


psql -U "$USERNAME" -d "$DB_NAME" -1 -f "$DUMP_FILE"