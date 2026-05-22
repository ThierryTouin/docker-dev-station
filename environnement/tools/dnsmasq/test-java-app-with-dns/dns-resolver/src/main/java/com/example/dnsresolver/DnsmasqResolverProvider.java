package com.example.dnsresolver;

import java.net.spi.InetAddressResolver;
import java.net.spi.InetAddressResolverProvider;

public class DnsmasqResolverProvider extends InetAddressResolverProvider {

    @Override
    public InetAddressResolver get(Configuration configuration) {
        String mode = System.getProperty("dns.mode", "dnsmasq");

        if ("local".equalsIgnoreCase(mode)) {
            boolean fallback = Boolean.parseBoolean(System.getProperty("dns.fallback", "true"));
            System.out.println("[dns-resolver] Mode: LOCAL (embedded DNS hosts)");
            return new LocalDnsResolver(fallback);
        } else {
            String dnsServer = System.getProperty("dns.server", "127.0.0.2");
            int dnsPort = Integer.parseInt(System.getProperty("dns.port", "53"));
            System.out.println("[dns-resolver] Mode: DNSMASQ (" + dnsServer + ":" + dnsPort + ")");
            return new DnsmasqResolver(dnsServer, dnsPort);
        }
    }

    @Override
    public String name() {
        return "DnsmasqResolver";
    }
}
