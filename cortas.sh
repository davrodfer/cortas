#!/bin/bash 

FILES=`dirname $0`/archivos
ARCHIVO=`echo ${SCRIPT_NAME} | tr -d '/-'`
URLFILE="${FILES}/${ARCHIVO}"
if [ -f ${URLFILE} ] ; then
  printf "Status: 301 Moved Permanently\r\n";
  echo -e "Location: "`cat -- ${URLFILE}`"\r\n\r\n"
else
  printf "Status: 404 Not found\r\n\r\n";
  echo No encontrado
fi

# printf "content-type: text/plain\r\n\r\n"
