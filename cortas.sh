#!/bin/bash 

FILES=`dirname $0`/archivos
ARCHIVO=`echo ${SCRIPT_NAME} | tr -d '/-'`
URLFILE="${FILES}/${ARCHIVO}"
if [ -f ${URLFILE} ] ; then
  printf "Status: 301 Moved Permanently\r\n"
  printf "cache-control: private, max-age=2592000\r\n"
  printf "Location: "`cat -- ${URLFILE} | tr -d '\r\n'`"\r\n\r\n"
else
  printf "Status: 404 Not found\r\n\r\n";
  echo No encontrado
fi