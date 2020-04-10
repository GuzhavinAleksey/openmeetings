# openmeetings
Docker image for OM (version 5.0.0-M4, WebRTC SEMI-STABLE)
Description	Value
Db type	MySql
Db root password	12345
OM DB user	om_admin
OM DB user password	12345
OM admin user	om_admin
OM admin user password	1Q2w3e4r5t^y

example docker-compose:

version: '3.7'

services:
  app_openweb:
    image: guzhavin/openmeetings
    expose:
      - "5443"
    ports:
      - 5443:5443
    volumes:
      - ./openweb/applicationContext.xml:/opt/openmeetings/webapps/openmeetings/WEB-INF/classes/applicationContext.xml
    depends_on:
      - app_coturn
      - app_kurento
    networks:
      - app_network_openweb

  app_kurento:
    image: kurento/kurento-media-server
    ports:
      - 8888:8888
    environment:
       KMS_TURN_URL: openweb:openDtcmfsa@HOST-IP:3478
    depends_on:
      - app_coturn
    networks:
      - app_network_openweb

  app_coturn:
    image: instrumentisto/coturn
    network_mode: "host"
    volumes:
      - ./coturn/my.conf:/etc/coturn/turnserver.conf
      


networks:
  app_network_openweb:
