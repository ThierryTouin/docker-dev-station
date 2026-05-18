package com.example.dnsresolver;

import java.net.spi.InetAddressResolver;
import java.net.spi.InetAddressResolverProvider;

public class DnsmasqResolverProvider extends InetAddressResolverProvider {

    @Override
    public InetAddressResolver get(Configuration configuration) {
        String dnsServer = System.getProperty("dns.server", "127.0.0.2");
        int dnsPort = Integer.parseInt(System.getProperty("dns.port", "53"));
        System.out.println("[dns-resolver] Using custom DNS: " + dnsServer + ":" + dnsPort);
        return new DnsmasqResolver(dnsServer, dnsPort);
    }

    @Override
    public String name() {
        return "DnsmasqResolver";
    }
}
