#!/bin/bash
set -euf -o pipefail

# shellcheck source=cortas.config
source "$(dirname "${0}")/cortas.config"
# shellcheck source=funciones.sh
source "${CODEDIR}/funciones.sh"

function ayuda {
  cat <<END; 
  --------------------
  Uso:
  --------------------
  ${0} -u URL [-c <NUM>] [-r <HTTPCODE>]

  Genera una nueva redirección a la URL indicada con el parámetro -u con las
  siguientes opciones:

  -c <NUM> Añade una cabecera de cache con los segundos indicados.
  -r <HTTPCODE> Devuelve el código HTTP, 301 o 302
END
}

# Valores por defecto
CODE=301
CACHE=$((86400*30))
URLREMOTA=""

while getopts "u:c:r:" opt; do
  case $opt in
    u) URLREMOTA="$OPTARG";;
    c) 
      if ! [[ "${OPTARG}" =~ ^[0-9]+$ ]] ; then
        err "error: ${OPTARG} no es un numero"
        ayuda
        exit 1
      fi
      CACHE="$OPTARG"
    ;;
    r)
      if [ "${OPTARG}" -eq "301" ] || [ "${OPTARG}" -eq "302" ] ; then
        CODE="$OPTARG"
      else
        err "${OPTARG} no es valido, tiene que ser 301 o 302"
        ayuda
        exit 1
      fi
    ;;
    \?) 
      err "Opcion invalida -$opt"
      ayuda 
      exit 1
    ;;
  esac
done

if [ -z "${URLREMOTA}" ] ; then
  err "Falta el parámetro con la url a reenviar"
  ayuda
  exit 1
fi

while : ; do
  CADENA="$(generaCadena "${BBDD}" "${ALFABETO}")"
  ARCHIVO="$(string2File "${BBDD}" "${ALFABETO}" "${CADENA}")"
  [[ -f "${ARCHIVO}" ]] && echo "El archivo generado ${ARCHIVO} ya existe" >&1 || break
done
DIRECTORIO="$(dirname "${ARCHIVO}")"
if [ ! -d "${DIRECTORIO}" ] ; then
  mkdir -p -- "${DIRECTORIO}"
fi
printf '{
  "url": "%s", 
  "code": %s, 
  "cache": %s
  }' "${URLREMOTA}" "${CODE}" "${CACHE}" > "${ARCHIVO}"
echo "${URLBASE}${CADENA}"