# openmeetings
- Docker image for OM (version 8.0.0 WebRTC SEMI-STABLE)
- build image example
```
podman image build -t openmeetings -f Dockerfile

```

|Description|Value|
|-----------|-----|
|Db type| MySql|
|Db root password|`12345`|
|OM DB user|`om_admin`|
|OM DB user password|`12345`|
|OM admin user|`om_admin`|
|OM admin user password|`1Q2w3e4r5t^y`|

# See example docker-compose.yml file!
mkdir:
mkdir -p openweb/{classes,conf,mysql} && mkdir coturn
