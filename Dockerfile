FROM ubuntu:19.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install --yes \
    wget \
    openjdk-11-jre-headless \
    net-tools \
    unzip \
  && rm --recursive --force /var/lib/apt/lists/*

ENV VERSION=6.10.1
ENV ARTIFACTORY_HOME=/opt/artifactory-cpp-ce-current

RUN wget --quiet -O /tmp/jfrog-artifactory-cpp-ce-${VERSION}.zip "https://bintray.com/jfrog/artifactory/download_file?file_path=jfrog-artifactory-cpp-ce-${VERSION}.zip" && \
    unzip /tmp/jfrog-artifactory-cpp-ce-${VERSION}.zip -d /opt && \
    ln -s /opt/artifactory-cpp-ce-${VERSION} ${ARTIFACTORY_HOME} && \
    rm /tmp/jfrog-artifactory-cpp-ce-${VERSION}.zip && \
    mv "${ARTIFACTORY_HOME}/etc" "${ARTIFACTORY_HOME}/etc.defaults"

VOLUME ${ARTIFACTORY_HOME}/etc
VOLUME ${ARTIFACTORY_HOME}/data
VOLUME ${ARTIFACTORY_HOME}/logs
VOLUME ${ARTIFACTORY_HOME}/backup

EXPOSE 8040

COPY start.sh /start.sh
RUN chmod +x /start.sh
ENTRYPOINT ["/start.sh"]
