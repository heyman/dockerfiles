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
RUN apt-get update

# Install Memcached
RUN apt-get install -y memcached
RUN mkdir /etc/service/memcached
RUN cp /build/memcached /etc/service/memcached/run
RUN cp /build/memcached.conf /etc/memcached.conf


# Remove build scripts
RUN rm -rf /build

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 11211

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
