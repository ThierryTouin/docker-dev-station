package com.example.dnscheck;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.List;

@Component
public class DnsChecker implements CommandLineRunner {

    private static final Logger log = LoggerFactory.getLogger(DnsChecker.class);

    @Value("${dns.check.domains:myoidc.local,dev1.local}")
    private List<String> domains;

    @Override
    public void run(String... args) {
        log.info("=========================================");
        log.info(" DNS Resolution Check (via JVM resolver)");
        log.info("=========================================");
        log.info("");

        int success = 0;
        int failure = 0;

        for (String domain : domains) {
            try {
                InetAddress address = InetAddress.getByName(domain);
                log.info("  [OK] {} -> {}", domain, address.getHostAddress());
                success++;
            } catch (UnknownHostException e) {
                log.error("  [KO] {} -> résolution impossible !", domain);
                failure++;
            }
        }

        log.info("");
        log.info("-----------------------------------------");
        log.info(" Résultat : {} OK / {} KO", success, failure);
        log.info("-----------------------------------------");

        if (failure > 0) {
            log.error("");
            log.error(" ATTENTION : certaines entrées DNS ne sont pas résolues.");
            log.error(" Vérifiez que :");
            log.error("   1. Le conteneur dnsmasq est démarré (docker ps)");
            log.error("   2. dnsmasq écoute sur le port 53");
            log.error("   3. La JVM utilise le bon DNS (-Dsun.net.spi.nameservice.nameservers=127.0.0.1)");
            log.error("");
        } else {
            log.info("");
            log.info(" Toutes les entrées DNS sont correctement résolues !");
            log.info("");
        }
    }
}
