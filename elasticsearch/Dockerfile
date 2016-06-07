# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:0.9.15

# Set correct environment variables.
ENV HOME /root

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Add build scripts
ADD . /build

# Install SSH key
RUN cat /build/id_rsa.pub >> /root/.ssh/authorized_keys && rm -f /build/id_rsa.pub

# ...put your own build instructions here...

# Add Java APT repo
RUN add-apt-repository -y ppa:webupd8team/java

RUN apt-get update

# Remove the license "popup" the Java installation tries to throw in your face
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections

# Install Java
RUN apt-get install -y oracle-java7-installer

# Install ElasticSearch
RUN \
  cd /tmp && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.3.4.tar.gz && \
  tar xvzf elasticsearch-1.3.4.tar.gz && \
  rm -f elasticsearch-1.3.4.tar.gz && \
  mv /tmp/elasticsearch-1.3.4 /elasticsearch

# Copy ElasticSearch config
RUN cp /build/elasticsearch.yml /elasticsearch/config/elasticsearch.yml

# Set up service startup script
RUN mkdir /etc/service/elasticsearch
RUN cp /build/run /etc/service/elasticsearch/run
RUN chmod +x /etc/service/elasticsearch/run

# Remove build scripts
RUN rm -rf /build

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/data"]
WORKDIR /data

EXPOSE 9200
EXPOSE 9300

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
