#!/bin/bash 
. `dirname $0`/cortas.config
. ${CODEDIR}/funciones.sh

if [ -z "${1}" ] ; then
  echo "Falta el parámetro con la url a reenviar"
  exit 1
fi

while : ; do
  CADENA=$(generaCadena "${BBDD}" "${ALFABETO}")
  ARCHIVO=$(string2File "${BBDD}" ${CADENA})
  [[ -f ${ARCHIVO} ]] || break
done
DIRECTORIO=`dirname $ARCHIVO`
if [ ! -d ${DIRECTORIO} ] ; then
  mkdir -p -- ${DIRECTORIO}
fi
echo $1 >> $ARCHIVO
echo ${URLBASE}${CADENA}