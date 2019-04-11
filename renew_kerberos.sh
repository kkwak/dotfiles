#!/bin/bash

declare -r SCRIPT_PATH=$(dirname $0)
declare -r HOSTNAME=$(hostname)

echo $(date +"%m%d %H:%M:%S") "Running $0"
pushd $SCRIPT_PATH

while [ 1 ]
do
  echo $(date +"%m%d %H:%M:%S") "Renewing tickets"
  kinit ${USER}@DOMAIN.COM -f -R -k -l10d -t ${USER}.keytab
  echo $(date +"%m%d %H:%M:%S") "Sleeping.."
  sleep 6h
done

popd
