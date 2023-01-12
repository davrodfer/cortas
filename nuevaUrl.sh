#!/bin/bash 
CODEDIR=`dirname $0`
. ${CODEDIR}/funciones.sh
FILES=${CODEDIR}/archivos 
if [ -z "${1}" ] ; then
  echo "Falta el parámetro con la url a reenviar"
  exit 1
fi

while : ; do
  CADENA=$(generaCadena "${FILES}" "${CODEDIR}/alfabeto")
  ARCHIVO=$(string2File "${FILES}" ${CADENA})
  [[ -f ${ARCHIVO} ]] || break
done
DIRECTORIO=`dirname $ARCHIVO`
if [ ! -d ${DIRECTORIO} ] ; then
  mkdir -p -- ${DIRECTORIO}
fi
echo $1 >> $ARCHIVO
echo `cat ${CODEDIR}/urlbase`${CADENA}