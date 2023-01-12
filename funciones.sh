#!/bin/bash

function string2File {
  Directorio=$1
  Cadena=$2
  Longitud=${#Cadena}
  Archivo=${Directorio}
  for i in `seq 1 ${Longitud}`; do 
    Caracter=`echo ${Cadena} | cut -c$i-$i`
    Archivo=${Archivo}/${Caracter}
  done
  echo ${Archivo}.data
}

function generaCadena {
  Directorio=$1
  Alfabeto=$2
  nLetras=`cat ${Alfabeto}| wc -l`
  #echo Directorio ${Directorio} Alfabeto ${Alfabeto} nLetras ${nLetras}
  Ultimo="${Directorio}/.last"
  if [ ! -f ${Ultimo} ]; then
    echo -1 > ${Ultimo}
  fi
  UltimoNumero=`cat -- ${Ultimo}`
  Numero=$((UltimoNumero + 1))
  echo ${Numero} > ${Ultimo}
  Cadena=""
  while : ; do
    Resto=$((Numero % nLetras))
    Numero=$((Numero - Resto))
    Numero=$((Numero / nLetras))
    Cadena=`head -$((Resto + 1)) ${Alfabeto} | tail -1`$Cadena
    [[ ${Numero} -ne 0 ]] || break
  done
  echo ${Cadena}
}

#Cadena=$(generaCadena "/opt/cortas/archivos" "/opt/cortas/alfabeto")
#echo $Cadena
#Resultado=$(string2File "/opt/cortas/archivos" ${Cadena})
#echo Resultado "'${Resultado}'"

