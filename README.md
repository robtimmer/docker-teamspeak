robtimmer/teamspeak
==================

Container storage (testing):

`docker run -d --name teamspeak -p 9987:9987/udp -p 30033:30033 -p 10011:10011 -p 41144:41144 robtimmer/teamspeak`

Persistent storage:

1. Create necessary directories, files, and set permissions:
  * `mkdir -p /data/teamspeak`
  * `touch /data/teamspeak/ts3server.sqlitedb`
  * `chown -R 503:503 /data/teamspeak`

2. Start container:
    ```
    docker run -d --restart=always --name teamspeak \
      -p 9987:9987/udp -p 30033:30033 -p 10011:10011 -p 41144:41144 \
      -v /data/teamspeak:/data \
      -v /data/teamspeak/ts3server.sqlitedb:/opt/teamspeak/ts3server.sqlitedb \
      robtimmer/teamspeak \
      logpath=/data/logs/ \
      query_ip_whitelist=/data/query_ip_whitelist.txt \
      query_ip_blacklist=/data/query_ip_blacklist.txt
    ```