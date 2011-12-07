#!/bin/bash

if (( $# < 3))
then 
	printf "%b" "Error. Not enough arguments.\n" >&2
	printf "%b" "Usage: `basename $0` <PDI_HOME> <DB_USER> <DB_PASSWORD>\n" >&2
	exit 1
elif (( $# > 3))
then
	printf "%b" "Error. Too many arguments.\n" >&2
	printf "%b" "Usage: `basename $0` <PDI_HOME> <DB_USER> <DB_PASSWORD>\n" >&2
	exit 2
fi

PDI_HOME="$1"
DBUSER="$2"
DBPASSWD="$3"


# Recreate the motech data warehouse and run ETL scripts to populate it with data

# 1. check for existing database

# create database for dw
mysqladmin -u"$DBUSER" -p"$DBPASSWD" drop motech_dw
mysqladmin -u"$DBUSER" -p"$DBPASSWD" create motech_dw

# create dw structure (sql) 
printf "%b" "Creating schema for database \n"
mysql -u"$DBUSER" -p"$DBPASSWD" -Dmotech_dw < motech_dw_schema.sql

# check for presence of source database

#run ETL job 
$PDI_HOME/./kitchen.sh -file=main_job.kjb -norep



