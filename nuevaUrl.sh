#!/bin/bash 
CODEDIR=`dirname $0`
FILES=${CODEDIR}/archivos 
if [ -z "${1}" ] ; then
  echo "Falta el parámetro con la url a reenviar"
  exit 1
fi

while : ; do
  ARCHIVO=${FILES}/$RANDOM 
  [[ -f ${ARCHIVO} ]] || break
done

echo $1 >> $ARCHIVO
echo `cat ${CODEDIR}/urlbase``basename $ARCHIVO`