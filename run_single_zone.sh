#!/bin/sh

if [ "$HEADER_COPY_DIRECTORY" ]
then
  cp /my-projects/single_zone/default/master.h ${HEADER_COPY_DIRECTORY}/master.h
else
  ./single_zone_network $VAR
fi

