#!/bin/bash
# Se le pasa un nombre de archivo con un numero como primer paramentro y se 
# incrementa ese valor Con el valor del segundo parametro. Si es negativo, 
# debería computarse bien.

# shellcheck source=./cortas.config
source "$(dirname "${0}")/cortas.config"
# shellcheck source=./funciones.sh
source "${CODEDIR}/funciones.sh"

Archivo="${1}"
Valor="${2}"

re='^[+-]?[0-9]+$'

if [ ! -f "${Archivo}" ]; then
  err "El archivo '${Archivo}' no existe"
  exit 1
fi
if ! [[ $Valor =~ $re ]] ; then
   err "El segundo parametro no es un numero"
   exit 1
fi
UltimoNumero=$(cat -- "${Archivo}")
if ! [[ $UltimoNumero =~ $re ]] ; then
   UltimoNumero=-1
fi
Numero=$((UltimoNumero + Valor))
echo "${Numero}" | tee "${Archivo}"