#!/bin/bash

# utility to assign container ID 
#
#  note: ID assigned to /opt/openapx/container-id
#  note: ID appended to /opt/openapx/container-provenance
#


if [ -z "${OPENAPX_CONTAINERID}" ]; then
  echo "Container ID (OPENAPX_CONTAINERID) not set in action (see Dockerfile)"
  exit 1
fi


# -- make sure scaffolding exists
mkdir -p /opt/openapx

# -- add container identity 
echo "${OPENAPX_CONTAINERID}" > /opt/openapx/container-id

# -- append container ID to provenance
echo "${OPENAPX_CONTAINERID}" >> /opt/openapx/container-provenance


exit 0 