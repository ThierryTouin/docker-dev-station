#!/bin/bash

# Build le JAR dns-resolver (fat-jar avec dnsjava embarqué)
# À exécuter une seule fois. Le JAR produit peut ensuite être utilisé
# avec n'importe quelle application Java 18+ sans modification de code.
#
# Usage: ./build.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "========================================"
echo " Build dns-resolver.jar"
echo "========================================"
echo ""

cd "$SCRIPT_DIR"
mvn -q clean package -DskipTests

JAR_PATH="$SCRIPT_DIR/target/dns-resolver-1.0.0.jar"

if [ -f "$JAR_PATH" ]; then
    echo ""
    echo "  [OK] JAR créé : $JAR_PATH"
    echo ""
    echo "========================================"
    echo " Utilisation"
    echo "========================================"
    echo ""
    echo "  Pour injecter le DNS custom dans une application Spring Boot :"
    echo ""
    echo "  # Via mvn spring-boot:run :"
    echo "  export JAVA_TOOL_OPTIONS=\"-Ddns.server=127.0.0.2 -Ddns.port=53\""
    echo "  mvn spring-boot:run -Dspring-boot.run.additionalClasspathElements=$JAR_PATH"
    echo ""
    echo "  # Via java -jar :"
    echo "  java -Ddns.server=127.0.0.2 -Ddns.port=53 -cp \"$JAR_PATH:app.jar\" org.springframework.boot.loader.launch.JarLauncher"
    echo ""
    echo "  # Via Spring Boot loader.path (recommandé pour fat-jar) :"
    echo "  java -Ddns.server=127.0.0.2 -Ddns.port=53 -Dloader.path=$JAR_PATH -jar app.jar"
    echo ""
else
    echo "  [KO] Echec du build."
    exit 1
fi
