#!/bin/sh
export LANG=C.UTF-8
export LC_ALL=C.UTF-8

MCHOME=/config/meshcore
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
DOCUDIR="${HOME}/Documents"
CONFDIR="${XDG_DATA_HOME}/MeshCore"


#set | sort

mkdir -p "${XDG_DATA_HOME}" || echo "ERROR making data home"
mkdir -p "${XDG_CONFIG_HOME}" || echo "ERROR making config home"
mkdir -p "${MCHOME}" || echo "ERROR making mchome"
if [ ! -L "${DOCUDIR}" ]; then
    echo "Creating DOCUDIR link"
    ln -s "${MCHOME}" "${DOCUDIR}" 
fi
if [ ! -L "${CONFDIR}" ]; then
    echo "Creating CONFDIR link"
    ln -s "${MCHOME}" "${CONFDIR}"
fi

#ls -lha $HOME
echo "config:"
ls -lha /config
echo "${MCHOME}:"
ls -lha "${MCHOME}"
echo "${XDG_DATA_HOME}:"
ls -lha "${XDG_DATA_HOME}"

#find /config

#find $HOME
xdg-user-dirs-update
xdg-user-dir DOCUMENTS


MESHCORE_BIN=$(find /opt/meshcore -maxdepth 3 -type f -name "MeshCore" | head -n 1)
if [ -z "${MESHCORE_BIN}" ]; then
    echo "ERROR: MeshCore binary not found under /opt/meshcore" >&2
    exit 1
fi
ls -lha "${MESHCORE_BIN}"
#ldd "${MESHCORE_BIN}"
exec "${MESHCORE_BIN}"
ls -lha "${XDG_DATA_HOME}"
