#!/bin/bash
set -euf -o pipefail

. `dirname $0`/cortas.config
. ${CODEDIR}/funciones.sh
CADENA=`echo ${SCRIPT_NAME} | tr -d '/-'`
URLFILE=$(string2File "${BBDD}" "${ALFABETO}" ${CADENA})
if [ -f ${URLFILE} ] ; then
  printf "Status: 301 Moved Permanently\r\n"
  printf "cache-control: public, max-age=2592000\r\n"
  printf "Location: "`cat -- ${URLFILE} | tr -d '\r\n'`"\r\n\r\n"
else
  printf "Status: 404 Not found\r\n\r\n";
  echo No encontrado
fi