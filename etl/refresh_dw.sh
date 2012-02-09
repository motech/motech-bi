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

#run ETL job 
$PDI_HOME/kitchen.sh /file:`readlink -f $PRGDIR/main_job.kjb`  -norep
