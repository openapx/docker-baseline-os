#!/bin/bash

# utility script to install binary dependencies
# usage 
#
#  bin-libs.sh [options] [file]
#
#  Options: 
#     --vith-updates    Install OS level updates
#     
#  <file>               List of binary dependencies. Use # for comments
#
#
#  note: uses ID in /etc/os-release to determine distribution and subsequent commands
#


# -- some defaults
FLAG_OSUPDATE=
LIBS_FILE=


# -- process arguments

while (($#)); do

  case ${1} in
         --with-updates)
                  FLAG_OSUPDATE=TRUE
                  shift 1
                  ;;

         *)
           # assuming argument by itself is a file
           LIBS_FILE=${1}
           shift 1
           ;;
  esac
done

# -- end of process arguments


# -- get OS branch

OS_RELEASE=$( grep -i "^id=" /etc/os-release | awk -F '=' '{print $2}' | xargs )

# -- define some basic commands based on OS

case ${OS_RELEASE} in
   ubuntu | debian)
      OS_UPDATE="apt-get update --assume-yes"
      OS_INSTALL_LIBS="apt-get install --assume-yes --no-install-recommends"
      ;;
    
   fedora | rocky)
      OS_UPDATE="dnf update --assumeyes"
      OS_INSTALL_LIBS="dnf install --assumeyes"
      ;;

    *)
      echo "Operating system ${OS_RELEASE} not supported"
      exit 1
      ;;
esac


# -- end of get OS branch


# -- process system/OS update
if [ -n "${FLAG_OSUPDATE}" ]; then

  eval "${OS_UPDATE}"

fi


# -- install any binary library dependenceis

if [ -z ${LIBS_FILE} ]; then
  echo "nothing"
  exit 0
fi


if ! [ -f "${LIBS_FILE}" ]; then
  echo "File ${LIBS_FILE} does not exist"
  exit 0
fi


eval "${OS_INSTALL_LIBS} $(grep "^[^#;]" ${LIBS_FILE} | tr '\n' ' ')"


