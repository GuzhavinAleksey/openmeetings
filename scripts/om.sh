#!/bin/bash
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

. ${work}/om_euser.sh

CLASSES_HOME=${OM_HOME}/webapps/openmeetings/WEB-INF/classes

if [ -n "${OM_KURENTO_WS_URL}" ]; then
	sed -i "s|p:kurentoWsUrl=\"\"|p:kurentoWsUrl=\"${OM_KURENTO_WS_URL}\"|g" ${CLASSES_HOME}/applicationContext.xml
fi
if [ -n "${TURN_URL}" ]; then
	sed -i "s|p:turnUrl=\"\"|p:turnUrl=\"${TURN_URL}\"|g" ${CLASSES_HOME}/applicationContext.xml
fi
if [ -n "${TURN_USER}" ]; then
	sed -i "s|p:turnUser=\"\"|p:turnUser=\"${TURN_USER}\"|g" ${CLASSES_HOME}/applicationContext.xml
fi
if [ -n "${TURN_PASS}" ]; then
	sed -i "s|p:turnSecret=\"\"|p:turnSecret=\"${TURN_PASS}\"|g" ${CLASSES_HOME}/applicationContext.xml
fi
cd ${OM_HOME}
sudo -u ${DAEMON_USER} ${OM_HOME}/bin/catalina.sh run
