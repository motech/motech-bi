#!/bin/bash

if (( $# < 4))
then 
	printf "%b" "Error. Not enough arguments.\n" >&2
	printf "%b" "Usage: `basename $0` <PDI_HOME> <DB_USER> <DB_PASSWORD> <DB_NAME>\n" >&2
	exit 1
elif (( $# > 4))
then
	printf "%b" "Error. Too many arguments.\n" >&2
	printf "%b" "Usage: `basename $0` <PDI_HOME> <DB_USER> <DB_PASSWORD> <DB_NAME>\n" >&2
	exit 2
fi

PRG="$0"

while [ -h "$PRG" ] ; do
  ls=`ls -ld "$PRG"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    PRG="$link"
  else
    PRG=`dirname "$PRG"`/"$link"
  fi
done


PRGDIR=`dirname "$PRG"`

PDI_HOME="$1"
DBUSER="$2"
DBPASSWD="$3"
DB_NAME="$4"




# Recreate the motech data warehouse and run ETL scripts to populate it with data

# 1. check for existing database

# create database for dw
printf "%b" "Creating database (will drop existing database if present) \n"
echo "drop database if exists $DB_NAME" | mysql -u"$DBUSER" -p"$DBPASSWD"
echo "create database $DB_NAME" | mysql -u"$DBUSER" -p"$DBPASSWD"

# create dw schema (sql) 
printf "%b" "Creating schema for database \n"
mysql -u"$DBUSER" -p"$DBPASSWD" -D"$DB_NAME" < $PRGDIR/motech_dw_schema.sql

#run ETL job 
$PDI_HOME/kitchen.sh /file:`readlink -f $PRGDIR/main_job.kjb`  -norep -param:Internal.Job.Filename.Directory=$PRGDIR
