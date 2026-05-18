package com.example.dnsresolver;

import org.xbill.DNS.*;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.net.spi.InetAddressResolver;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Stream;

public class DnsmasqResolver implements InetAddressResolver {

    private final SimpleResolver resolver;

    public DnsmasqResolver(String dnsServer, int dnsPort) {
        try {
            this.resolver = new SimpleResolver(dnsServer);
            this.resolver.setPort(dnsPort);
            this.resolver.setTimeout(java.time.Duration.ofSeconds(5));
        } catch (UnknownHostException e) {
            throw new RuntimeException("Cannot create DNS resolver for " + dnsServer + ":" + dnsPort, e);
        }
    }

    @Override
    public Stream<InetAddress> lookupByName(String host, LookupPolicy lookupPolicy) throws UnknownHostException {
        List<InetAddress> addresses = new ArrayList<>();

        try {
            // Requête A (IPv4)
            if ((lookupPolicy.characteristics() & LookupPolicy.IPV4) != 0 || lookupPolicy.characteristics() == 0) {
                Lookup lookup = new Lookup(host, Type.A);
                lookup.setResolver(resolver);
                lookup.run();
                if (lookup.getResult() == Lookup.SUCCESSFUL) {
                    for (org.xbill.DNS.Record record : lookup.getAnswers()) {
                        if (record instanceof ARecord aRecord) {
                            addresses.add(aRecord.getAddress());
                        }
                    }
                }
            }

            // Requête AAAA (IPv6)
            if ((lookupPolicy.characteristics() & LookupPolicy.IPV6) != 0) {
                Lookup lookup = new Lookup(host, Type.AAAA);
                lookup.setResolver(resolver);
                lookup.run();
                if (lookup.getResult() == Lookup.SUCCESSFUL) {
                    for (org.xbill.DNS.Record record : lookup.getAnswers()) {
                        if (record instanceof AAAARecord aaaaRecord) {
                            addresses.add(aaaaRecord.getAddress());
                        }
                    }
                }
            }
        } catch (TextParseException e) {
            throw new UnknownHostException("Invalid hostname: " + host);
        }

        if (addresses.isEmpty()) {
            throw new UnknownHostException(host);
        }

        return addresses.stream();
    }

    @Override
    public String lookupByAddress(byte[] addr) throws UnknownHostException {
        try {
            InetAddress address = InetAddress.getByAddress(addr);
            Name name = ReverseMap.fromAddress(address);
            Lookup lookup = new Lookup(name, Type.PTR);
            lookup.setResolver(resolver);
            lookup.run();
            if (lookup.getResult() == Lookup.SUCCESSFUL) {
                for (org.xbill.DNS.Record record : lookup.getAnswers()) {
                    if (record instanceof PTRRecord ptrRecord) {
                        return ptrRecord.getTarget().toString(true);
                    }
                }
            }
        } catch (Exception e) {
            // fall through
        }
        throw new UnknownHostException("No PTR record for address");
    }
}
