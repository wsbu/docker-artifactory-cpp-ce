FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install --yes \
  wget \
  openjdk-8-jre \
  unzip

ENV ARTIFACTORY_HOME=/opt/artifactory-cpp-ce-5.11.0
RUN wget -O /tmp/jfrog-artifactory-cpp-ce-5.11.0.zip https://bintray.com/jfrog/artifactory/download_file?file_path=jfrog-artifactory-cpp-ce-5.11.0.zip
RUN unzip /tmp/jfrog-artifactory-cpp-ce-5.11.0.zip -d /opt
RUN mv "${ARTIFACTORY_HOME}/etc" "${ARTIFACTORY_HOME}/etc.defaults"

COPY start.sh /start.sh
RUN chmod +x /start.sh
ENTRYPOINT ["/start.sh"]
