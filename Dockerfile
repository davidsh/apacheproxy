# Clone from the Fedora 28 image
FROM fedora:28

MAINTAINER David Shulman <david.shulman@microsoft.com>

# Install Kerberos, mod_auth_kerb
RUN dnf install -y \
  httpd \
  iproute \
  && dnf clean all

# Add conf files for apache proxy
ADD proxy.conf /etc/httpd/conf.d/proxy.conf

# 80   = http (test page for apache web server)
# 8080 = apache proxy - anonymous
# 8081 = apache proxy - basic auth
EXPOSE 80 8080 8081

ADD configure /usr/sbin/configure
ENTRYPOINT /usr/sbin/configure
