# test-java-app-with-dns

Démonstration d'injection de résolution DNS personnalisée dans une application Java **sans modification de code applicatif**, via un Java Agent et le SPI `InetAddressResolverProvider` (Java 18+).

## Architecture

```
┌─────────────────────────────────────────────────────────┐
│  Application Java (ex: Spring Boot)                     │
│                                                         │
│    InetAddress.getByName("myoidc.local")                │
│         │                                               │
│         ▼                                               │
│    ┌──────────────────────────────────┐                 │
│    │ SPI InetAddressResolverProvider  │  (Java 18+)     │
│    └──────────────┬───────────────────┘                 │
│                   │                                     │
│         ┌─────────┴─────────┐                           │
│         ▼                   ▼                           │
│  ┌─────────────┐    ┌──────────────┐                   │
│  │   Mode DNS  │    │  Mode Local  │                   │
│  │  (dnsmasq)  │    │  (embarqué)  │                   │
│  └──────┬──────┘    └──────┬───────┘                   │
│         │                  │                            │
│         ▼                  ▼                            │
│   Serveur dnsmasq    Fichier dns-hosts.properties       │
│   (conteneur Docker) (dans le JAR ou sur disque)        │
└─────────────────────────────────────────────────────────┘
```

## Structure du projet

```
test-java-app-with-dns/
├── dns-resolver/             # Agent Java (fat-jar)
│   ├── pom.xml
│   ├── build.sh
│   └── src/main/java/com/example/dnsresolver/
│       ├── Agent.java                    # Point d'entrée de l'agent
│       ├── DnsmasqResolver.java          # Mode externe (requêtes vers dnsmasq)
│       ├── DnsmasqResolverProvider.java  # SPI Provider
│       └── LocalDnsResolver.java         # Mode embarqué (résolution locale)
├── demo-springboot/          # Application de test
│   ├── pom.xml
│   └── src/main/java/com/example/dnscheck/
│       ├── DnsCheckApplication.java
│       └── DnsChecker.java
├── run.sh                    # Script de lancement (mode dnsmasq)
├── run-local.sh              # Script de lancement (mode local embarqué)
└── README.md
```

## Prérequis

- Java 21+
- Maven 3.8+

## Mode 1 : Serveur DNS externe (dnsmasq)

Ce mode nécessite un conteneur dnsmasq en cours d'exécution.

### Démarrer dnsmasq

```bash
cd environnement/tools/dnsmasq
docker compose -f dnsmasq-compose.yml up -d
```

### Lancer l'application

```bash
./run.sh
```

Le script :
1. Vérifie que dnsmasq répond
2. Build le `dns-resolver.jar` (si nécessaire)
3. Configure `JAVA_TOOL_OPTIONS` avec `-javaagent:dns-resolver.jar`
4. Lance l'app Spring Boot qui résout les noms via dnsmasq

### Paramètres JVM (mode dnsmasq)

| Propriété      | Défaut     | Description                    |
|----------------|------------|--------------------------------|
| `dns.server`   | `127.0.0.2`| Adresse IP du serveur dnsmasq |
| `dns.port`     | `53`       | Port du serveur dnsmasq        |
| `dns.mode`     | `dnsmasq`  | Mode de résolution             |

## Mode 2 : DNS embarqué (sans serveur externe)

Ce mode intègre directement les correspondances DNS dans l'agent Java. **Aucun serveur DNS externe n'est nécessaire.** Idéal quand :
- Le serveur dnsmasq ne peut pas démarrer (contraintes client)
- Seule l'application Java a besoin de résoudre ces noms
- Environnement restreint sans Docker

### Lancer l'application

```bash
./run-local.sh
```

### Configuration des entrées DNS

Les correspondances sont définies dans un fichier `dns-hosts.properties` :

```properties
# Format : hostname=adresse_ip
myoidc.local=127.0.0.1
dev1.local=127.0.0.1
myapp.internal=10.0.0.50
```

Le fichier est cherché dans cet ordre :
1. Chemin spécifié par `-Ddns.hosts.file=/path/to/file.properties`
2. `dns-hosts.properties` dans le répertoire courant
3. `dns-hosts.properties` embarqué dans le JAR (classpath)

### Paramètres JVM (mode local)

| Propriété        | Défaut     | Description                              |
|------------------|------------|------------------------------------------|
| `dns.mode`       | `dnsmasq`  | Mettre à `local` pour le mode embarqué  |
| `dns.hosts.file` | _(auto)_   | Chemin vers le fichier de correspondances |
| `dns.fallback`   | `true`     | Fallback vers le resolver système si non trouvé |

### Exemple d'utilisation dans un projet client

```bash
# Build une seule fois
cd dns-resolver && ./build.sh

# Utiliser avec n'importe quelle app Java
java -javaagent:dns-resolver-1.0.0.jar \
     -Ddns.mode=local \
     -Ddns.hosts.file=/etc/myapp/dns-hosts.properties \
     -jar mon-application.jar
```

## Fonctionnement technique

### SPI InetAddressResolverProvider (Java 18+)

Depuis Java 18 ([JEP 418](https://openjdk.org/jeps/418)), il est possible de remplacer le resolver DNS de la JVM via le mécanisme SPI (Service Provider Interface). Le fichier `META-INF/services/java.net.spi.InetAddressResolverProvider` déclare notre implémentation.

### Pourquoi un Java Agent ?

Le `-javaagent:` garantit que le JAR est ajouté au **system classpath** au démarrage. C'est nécessaire car `ServiceLoader` dans `java.base` ne voit que le system classpath (pas le classpath applicatif).

### Mode local vs serveur DNS

| Aspect                  | Mode dnsmasq           | Mode local (embarqué)     |
|-------------------------|------------------------|---------------------------|
| Dépendance externe      | Conteneur Docker       | Aucune                    |
| Performance             | Requête réseau UDP     | HashMap en mémoire        |
| Domaines non mappés     | Forwarding DNS upstream| Fallback resolver système |
| Cas d'usage             | Infra partagée         | App isolée / env. client  |
