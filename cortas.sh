#!/bin/bash 
CODEDIR=`dirname $0`
FILES=${CODEDIR}/archivos
. ${CODEDIR}/funciones.sh
CADENA=`echo ${SCRIPT_NAME} | tr -d '/-'`
URLFILE=$(string2File "${FILES}" ${CADENA})
if [ -f ${URLFILE} ] ; then
  printf "Status: 301 Moved Permanently\r\n"
  printf "cache-control: private, max-age=2592000\r\n"
  printf "Location: "`cat -- ${URLFILE} | tr -d '\r\n'`"\r\n\r\n"
else
  printf "Status: 404 Not found\r\n\r\n";
  echo No encontrado
fi