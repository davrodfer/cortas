#!/bin/bash 
 
if [ -z "${1}" ] ; then
  echo "Falta el parámetro con la url a reenviar"
  exit 1
fi
CODEDIR=`dirname $0`
FILES=${CODEDIR}/archivos
while : ; do
  ARCHIVO=${FILES}/$RANDOM 
  [[ -f ${ARCHIVO} ]] || break
done

echo $1 >> $ARCHIVO
echo $ARCHIVO
echo `cat ${CODEDIR}/urlbase``basename $ARCHIVO`
