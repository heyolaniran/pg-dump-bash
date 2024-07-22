#!/bin/bash

#Verify if username is provided 

if [ -z "$1" ] ; then 
    read -p "Enter db Username :" USERNAME 
else
    USERNAME = $1 
fi 

if [-z "$2"]; then 
    read -p "DB Password: " DB_PASSWORD
else 
    DB_PASSWORD = $2
fi

# export the password then psql can use it 
export PGPASSWORD = $DB_PASSWORD


#Verify if database name is provided

if [-z "$3"] ; then 
    read -p "Enter database name: " DB_NAME 
else 
    DB_NAME = $3
fi

#CHECK IF DB_NAME Exist if not we'll create it 

DB_EXIST = $(psql -U $USERNAME -tc "SELECT 1 FROM pg_database WHERE datname = '$DB_NAME';") 


if [[ DB_EXIST != 1 ]]; then 
    echo "Database do not exist. Creating $DB_NAME..." 
    createdb -U $USERNAME $DB_NAME
fi