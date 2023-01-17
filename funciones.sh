#!/bin/bash
function err {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
}

function string2File {
  Directorio="$1"
  Cadena="$3"
  Alfabeto="$2"
  if [ -z "${1}" ] ; then
    err "Falta el parámetro 1 con el directorio donde se crean los archivos"
    exit 1
  fi
  if [ -z "${2}" ] ; then
    err "Falta el parámetro 2 con la cadena a convertir en archivo"
    exit 1
  fi
  Longitud="${#Cadena}"
  Archivo="${Directorio}"
  for i in $(seq 1 "${Longitud}") ; do 
    Caracter=$(echo "${Cadena}" | cut -c"$i"-"$i")
    if grep -q "${Caracter}" -- "${Alfabeto}" ; then
      Archivo="${Archivo}/${Caracter}"
    else
      err "Caracter '${Caracter}' no es valido"
      exit 1
    fi
  done
  echo "${Archivo}.data"
}

function numero2cadena {
  if [ -z "${1}" ] ; then
    err "Falta el parámetro 1 con el numero origen"
    exit 1
  fi

  if [ -z "${2}" ] ; then
    err "Falta el parámetro 2 con la localización del fichero alfabeto"
    exit 1
  fi
  Numero="${1}"
  Alfabeto="$2"
  nLetras=$(wc -l < "${Alfabeto}")
  Cadena=""
  while : ; do
    Resto=$((Numero % nLetras))
    Numero=$((Numero - Resto))
    Numero=$((Numero / nLetras))
    Cadena=$(head -$((Resto + 1)) "${Alfabeto}" | tail -1)$Cadena
    [[ ${Numero} -ne 0 ]] || break
  done
  echo "${Cadena}"
}

function generaCadena {
  Directorio="$1"
  Alfabeto="$2"
  if [ -z "${1}" ] ; then
    err "Falta el parámetro 1 con el directorio donde se crean los archivos"
    exit 1
  fi
  if [ -z "${2}" ] ; then
    err "Falta el parámetro 2 con la localización del fichero alfabeto"
    exit 1
  fi
  if [ ! -d "${Directorio}" ] ; then
    err "No exite el directorio '${Directorio}', se crea"
    mkdir -p -- "${Directorio}"   
  fi
  
  Ultimo="${Directorio}/.last"
  if [ ! -f "${Ultimo}" ]; then
    echo -1 > "${Ultimo}"
  fi
  UltimoNumero=$(cat -- "${Ultimo}")
  Numero=$((UltimoNumero + 1))
  echo "${Numero}" > "${Ultimo}"
  
  echo "$(numero2cadena "${Numero}" "${Alfabeto}")"
}
#Main
set -euf -o pipefail