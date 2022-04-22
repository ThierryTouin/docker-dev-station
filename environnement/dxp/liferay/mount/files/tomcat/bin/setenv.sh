CATALINA_OPTS="$CATALINA_OPTS -Dfile.encoding=UTF-8 -Djava.locale.providers=JRE,COMPAT,CLDR -Djava.net.preferIPv4Stack=true -Duser.timezone=GMT -Xms2560m -Xmx2560m -XX:MaxNewSize=1536m -XX:MaxMetaspaceSize=768m -XX:MetaspaceSize=768m -XX:NewSize=1536m -XX:SurvivorRatio=7"
CATALINA_OPTS="${CATALINA_OPTS} ${LIFERAY_JVM_OPTS}"

CATALINA_OPTS="$CATALINA_OPTS -Xdebug -Xrunjdwp:transport=dt_socket,address=0.0.0.0:5005,server=y,suspend=n"