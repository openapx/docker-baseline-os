#!/bin/bash

# utility to assign container ID 
#
#  note: ID assigned to /opt/openapx/container-id
#  note: ID appended to /opt/openapx/container-provenance
#


if [ -z "${ACTION_CONTAINER_ID}" ]; then
  echo "Container ID (ACTION_CONTAINER_ID) not set in action"
  exit 1
fi


# -- make sure scaffolding exists
mkdir -p /opt/openapx

# -- add container identity 
echo "${ACTION_CONTAINER_ID}" > /opt/openapx/container-id

# -- append container ID to provenance
echo "${ACTION_CONTAINER_ID}" >> /opt/openapx/container-provenance


exit 0 