#!/bin/bash
set -euf -o pipefail

# shellcheck source=cortas.config
source "$(dirname "${0}")/cortas.config"
# shellcheck source=funciones.sh
source "${CODEDIR}/funciones.sh"

if [ -z "${1}" ] ; then
  err "Falta el parámetro con la url a reenviar"
  exit 1
fi
URLREMOTA="${1}"
CODE="301"
if [ -n "${2}" ] ; then
  CODE="${2}"
fi

while : ; do
  CADENA="$(generaCadena "${BBDD}" "${ALFABETO}")"
  ARCHIVO="$(string2File "${BBDD}" "${ALFABETO}" "${CADENA}")"
  [[ -f "${ARCHIVO}" ]] || break
done
DIRECTORIO="$(dirname "${ARCHIVO}")"
if [ ! -d "${DIRECTORIO}" ] ; then
  mkdir -p -- "${DIRECTORIO}"
fi
printf '{"url": "%s", "code":%s, "cache":2592005}' "${URLREMOTA}" "${CODE}" > "${ARCHIVO}"
echo "${URLBASE}${CADENA}"