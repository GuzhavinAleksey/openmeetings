# #############################################
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# #############################################

FROM ubuntu:18.04
ENV OM_VER_MAJ='5'
ENV OM_VER_MIN='0'
ENV OM_VER_MIC='0-M3.1'
ENV OM_VERSION="${OM_VER_MAJ}.${OM_VER_MIN}.${OM_VER_MIC}"
LABEL vendor="Apache OpenMeetings dev team"
LABEL version="${OM_VERSION}"
LABEL maintainer=dev@openmeetings.apache.org


ENV OM_DATA_DIR="/opt/omdata"
ENV work=/opt
ENV OM_HOME=/opt/openmeetings
ENV MYSQL_J_VER="8.0.19"
ENV DB2_J_VER="11.5.0.0"
ENV PORTS=5443

WORKDIR ${OM_HOME}
RUN cat /etc/issue \
  \
  && apt-get update && apt-get install -y --no-install-recommends \
    apt-utils \
  && apt-get install -y --no-install-recommends \
    software-properties-common \
    gnupg2 \
    dirmngr \
    unzip \
    wget \
    ghostscript \
    libgs-dev \
    imagemagick \
    sox \
    sudo \
    libreoffice \
    openjdk-11-jre \
    ffmpeg \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  \
  && wget https://builds.apache.org/view/M-R/view/OpenMeetings/job/openmeetings/lastSuccessfulBuild/artifact/openmeetings-server/target/apache-openmeetings-${OM_VERSION}-SNAPSHOT.tar.gz -O ${work}/om.tar.gz \
  && tar -xzf ${work}/om.tar.gz --strip-components=1 -C ${OM_HOME}/ \
  && rm -rf ${work}/om.tar.gz \
  && wget https://repo1.maven.org/maven2/mysql/mysql-connector-java/${MYSQL_J_VER}/mysql-connector-java-${MYSQL_J_VER}.jar -P ${OM_HOME}/webapps/openmeetings/WEB-INF/lib \
  && wget https://repo1.maven.org/maven2/com/ibm/db2/jcc/${DB2_J_VER}/jcc-${DB2_J_VER}.jar -P ${OM_HOME}/webapps/openmeetings/WEB-INF/lib \
  && sed -i 's|<policy domain="coder" rights="none" pattern="PS" />|<!--policy domain="coder" rights="none" pattern="PS" />|g; s|<policy domain="coder" rights="none" pattern="XPS" />|<policy domain="coder" rights="none" pattern="XPS" /-->|g' /etc/ImageMagick-6/policy.xml


WORKDIR ${work}
COPY scripts/*.sh ./

RUN chmod a+x ${work}/*.sh 

EXPOSE ${PORTS}

ENTRYPOINT [ "bash", "-c", "${work}/om.sh" ]
