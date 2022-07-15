CATALINA_OPTS="$CATALINA_OPTS -Dfile.encoding=UTF-8 -Djava.locale.providers=JRE,COMPAT,CLDR -Djava.net.preferIPv4Stack=true -Duser.timezone=GMT -Xms2560m -Xmx2560m -XX:MaxNewSize=1536m -XX:MaxMetaspaceSize=768m -XX:MetaspaceSize=768m -XX:NewSize=1536m -XX:SurvivorRatio=7"
CATALINA_OPTS="${CATALINA_OPTS} ${LIFERAY_JVM_OPTS}"

CATALINA_OPTS="$CATALINA_OPTS -Xdebug -Xrunjdwp:transport=dt_socket,address=0.0.0.0:5005,server=y,suspend=n"


# DATASOURCE
CATALINA_OPTS="$CATALINA_OPTS -DLCP_SECRET_DATABASE_NAME=$LCP_SECRET_DATABASE_NAME"

# APM
CATALINA_OPTS="$CATALINA_OPTS -javaagent:/opt/liferay/apm/glowroot.jar -Dglowroot.agent.id=tomcat -Dglowroot.collector.address=glowroot:8181"

# Proxy
#CATALINA_OPTS="$CATALINA_OPTS -Dhttp.nonProxyHosts=\"elasticsearch|glowroot\"  -Dhttp.proxyHost=dds_proxy  -Dhttp.proxyPort=3128  -Dhttp.proxyUser=test  -Dhttp.proxyPassword=test "
#CATALINA_OPTS="$CATALINA_OPTS -Dhttps.nonProxyHosts=\"elasticsearch|glowroot\" -Dhttps.proxyHost=dds_proxy -Dhttps.proxyPort=3128 -Dhttps.proxyUser=test -Dhttps.proxyPassword=test "
CATALINA_OPTS="$CATALINA_OPTS -Dhttp.nonProxyHosts=\"elasticsearch|glowroot\"  -Dhttp.proxyHost=dds_proxy  -Dhttp.proxyPort=3128  "
CATALINA_OPTS="$CATALINA_OPTS -Dhttps.nonProxyHosts=\"elasticsearch|glowroot\" -Dhttps.proxyHost=dds_proxy -Dhttps.proxyPort=3128 "
