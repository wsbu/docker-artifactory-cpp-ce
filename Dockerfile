FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install --yes \
  wget \
  openjdk-8-jre

RUN wget --quiet -O /tmp/jfrog-artifactory-cpp-ce-5.11.0.deb https://bintray.com/jfrog/artifactory-debs/download_file?file_path=pool%2Fmain%2Fj%2Fjfrog-artifactory-cpp-ce-deb%2Fjfrog-artifactory-cpp-ce-5.11.0.deb
RUN dpkg -i /tmp/jfrog-artifactory-cpp-ce-5.11.0.deb; exit 0
RUN apt-get install --yes --fix-broken
