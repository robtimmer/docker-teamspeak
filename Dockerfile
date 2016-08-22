FROM debian:jessie
MAINTAINER rob@robtimmer.com

# Expose required ports
EXPOSE 9987/udp 10011 30033

# Install teamspeak3 server
RUN apt-get update && apt-get install -y bzip2 w3m wget && rm -rf /var/lib/apt/lists/* &&\
  TS_SERVER_VER="$(w3m -dump https://www.teamspeak.com/downloads | grep -m 1 'Server 64-bit ' | awk '{print $NF}')" &&\
  wget http://dl.4players.de/ts/releases/${TS_SERVER_VER}/teamspeak3-server_linux_amd64-${TS_SERVER_VER}.tar.bz2 -O /tmp/teamspeak.tar.bz2 &&\
  tar jxf /tmp/teamspeak.tar.bz2 -C /opt &&\
  mv /opt/teamspeak3-server_* /opt/teamspeak &&\
  rm /tmp/teamspeak.tar.bz2 &&\
  apt-get purge -y bzip2 w3m &&\
  apt-get autoremove -y

# Add user
RUN groupadd -g 503 teamspeak &&\
  useradd -u 503 -g 503 -d /opt/teamspeak teamspeak &&\
  chown -R teamspeak:teamspeak /opt/teamspeak

# Set the user
USER teamspeak
# Start the app
ENTRYPOINT ["/opt/teamspeak/ts3server_minimal_runscript.sh"]