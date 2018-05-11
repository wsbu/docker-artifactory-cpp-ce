#!/bin/bash



if [[ ! -d "${ARTIFACTORY_HOME}/etc" ]] ; then
    echo "Artifactory configuration files must be mounted to '${ARTIFACTORY_HOME}/etc' - rerun with Docker's --volume argument."
    exit 1
elif [ ! "$(ls -A ${ARTIFACTORY_HOME})" ] ; then
    set -e
    echo "First startup detected. Copying default configuration files."
    find "${ARTIFACTORY_HOME}/etc.defaults" -type f -exec cp {} "${ARTIFACTORY_HOME}/etc" \;
fi

if [[ ! -d "${ARTIFACTORY_HOME}/data" ]] ; then
    echo "Artifactory data directory must be mounted to '${ARTIFACTORY_HOME}/data' - rerun with Docker's --volume argument."
    exit 2
fi

"${ARTIFACTORY_HOME}/bin/artifactory.sh" start
tail -F "${ARTIFACTORY_HOME}/logs/artifactory.log" &

# Hold here until Artifactory exits
while pgrep -f java > /dev/null; do sleep 1; done;
