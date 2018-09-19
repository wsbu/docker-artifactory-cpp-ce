#!/bin/bash

if [ ! "$(ls -A ${ARTIFACTORY_HOME})" ] ; then
    set -e
    echo "First startup detected. Copying default configuration files."
    find "${ARTIFACTORY_HOME}/etc.defaults" -type f -exec cp {} "${ARTIFACTORY_HOME}/etc" \;
fi

"${ARTIFACTORY_HOME}/bin/artifactory.sh" start
tail -F "${ARTIFACTORY_HOME}/logs/artifactory.log" &

# Hold here until Artifactory exits
while pgrep -f java > /dev/null; do sleep 1; done;
