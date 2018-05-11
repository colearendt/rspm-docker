#!/bin/bash

set -e

if [ -z "${RSPM_LICENSE}" ]; then
	echo >&2 'error: The RSPM_LICENSE variable is not set.'
	"$@"
	exit 1
fi

activate() {
    echo "Activating license ..."
    /opt/rstudio-pm/bin/license-manager activate $RSPM_LICENSE # output is informative.
    if [ $? -ne 0 ]
    then
        echo >&2 'error: RSPM_LICENSE could not be activated.'
        exit 1
    fi     
}

deactivate() {
     echo "Deactivating license ..."
     /opt/rstudio-pm/bin/license-manager deactivate >/dev/null 2>&1
}

activate

trap deactivate EXIT 

echo "Starting RStudio Package Manager"
/opt/rstudio-pm/bin/rstudio-pm --config /etc/rstudio-pm/rstudio-pm.gcfg

tail -F /var/log/rstudio-pm.log && \ 
wait
