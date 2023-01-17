#!/bin/bash
set -euf -o pipefail

# shellcheck source=cortas.config
source "$(dirname "${0}")/cortas.config"
# shellcheck source=funciones.sh
source "${CODEDIR}/funciones.sh"

CADENA=$(echo "${SCRIPT_NAME}" | tr -d '/-')
URLFILE=$(string2File "${BBDD}" "${ALFABETO}" "${CADENA}")

if [ -f "${URLFILE}" ] ; then
  REMOTEURL="$(jq -r .url "${URLFILE}")"
  if [ "${REMOTEURL}" == "null" ] ; then
    REMOTEURL="about:blank"
  fi

  CACHE="$(jq -r .cache "${URLFILE}")"
  if [ "${CACHE}" == "null" ] ; then
    CACHE="2592006"
  fi

  CODE="$(jq -r .code "${URLFILE}"   || echo 301)"
  if [ "${CODE}" == "null" ] ; then
    CODE="302"
  fi

  if [ "${CODE}" == "301" ] ; then
    printf "Status: 301 Moved Permanently\r\n"
  else
    printf "Status: 302 Found\r\n"
  fi
  printf "cache-control: public, max-age=%s\r\n" "${CACHE}"
  printf "Location: %s\r\n\r\n" "${REMOTEURL}"
else
  printf "Status: 404 Not found\r\n\r\n";
  echo No encontrado
fi