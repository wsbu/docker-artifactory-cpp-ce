#!/bin/bash



if [[ ! -d /etc/opt/jfrog/artifactory ]] ; then
    echo "Artifactory configuration files must be mounted to /etc/opt/jfrog/artifactory. Rerun with Docker's --volume argument."
    exit 1
elif [ ! "$(ls -A /etc/opt/jfrog/artifactory)" ] ; then
    set -e
    echo "First startup detected. Copying default configuration files."
    find /etc/opt/jfrog/artifactory.default -type f -exec cp {} /etc/opt/jfrog/artifactory \;
fi

service artifactory start
tail -F /var/opt/jfrog/artifactory/logs/artifactory.log &

# Hold here until Artifactory exits
while pgrep -f java > /dev/null; do sleep 1; done;
