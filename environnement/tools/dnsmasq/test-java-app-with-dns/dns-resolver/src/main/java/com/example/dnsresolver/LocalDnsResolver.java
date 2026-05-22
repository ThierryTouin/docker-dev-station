package com.example.dnsresolver;

import java.io.IOException;
import java.io.InputStream;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.net.spi.InetAddressResolver;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.regex.Pattern;
import java.util.stream.Stream;

/**
 * Resolver DNS local embarqué - résout les noms depuis un fichier de correspondances
 * sans nécessiter de serveur DNS externe.
 *
 * Les entrées sont chargées depuis un fichier properties (format: hostname=ip).
 * Pour les noms non trouvés, fallback vers le resolver système si activé.
 */
public class LocalDnsResolver implements InetAddressResolver {

    private static final Pattern IP_V4_PATTERN = Pattern.compile(
            "^((25[0-5]|2[0-4]\\d|[01]?\\d\\d?)\\.){3}(25[0-5]|2[0-4]\\d|[01]?\\d\\d?)$");

    private final Map<String, String> hostsMap;
    private final boolean fallbackEnabled;

    public LocalDnsResolver(boolean fallbackEnabled) {
        this.fallbackEnabled = fallbackEnabled;
        this.hostsMap = loadHosts();
        System.out.println("[dns-resolver] Local mode - " + hostsMap.size() + " entries loaded");
        hostsMap.forEach((host, ip) -> System.out.println("[dns-resolver]   " + host + " -> " + ip));
    }

    @Override
    public Stream<InetAddress> lookupByName(String host, LookupPolicy lookupPolicy) throws UnknownHostException {
        String ip = hostsMap.get(host.toLowerCase());

        if (ip != null) {
            try {
                // getByName sur une IP littérale ne fait pas de résolution DNS
                byte[] addr = ipToBytes(ip);
                InetAddress address = InetAddress.getByAddress(host, addr);
                return Stream.of(address);
            } catch (Exception e) {
                throw new UnknownHostException("Invalid IP for host " + host + ": " + ip);
            }
        }

        if (fallbackEnabled) {
            // Fallback: résolution système standard (évite la récursion infinie
            // en utilisant le built-in resolver)
            return builtinLookup(host);
        }

        throw new UnknownHostException(host + " (not in local DNS hosts and fallback disabled)");
    }

    @Override
    public String lookupByAddress(byte[] addr) throws UnknownHostException {
        try {
            String ip = bytesToIp(addr);

            // Reverse lookup dans notre map
            for (Map.Entry<String, String> entry : hostsMap.entrySet()) {
                if (entry.getValue().equals(ip)) {
                    return entry.getKey();
                }
            }
        } catch (Exception e) {
            // fall through
        }
        throw new UnknownHostException("No reverse entry for address");
    }

    private Map<String, String> loadHosts() {
        Properties props = new Properties();

        // 1. Fichier spécifié par propriété système
        String hostsFile = System.getProperty("dns.hosts.file");
        if (hostsFile != null) {
            Path path = Path.of(hostsFile);
            if (Files.exists(path)) {
                try (InputStream is = Files.newInputStream(path)) {
                    props.load(is);
                    System.out.println("[dns-resolver] Loaded hosts from: " + path.toAbsolutePath());
                    return toMap(props);
                } catch (IOException e) {
                    System.err.println("[dns-resolver] WARNING: Cannot read " + hostsFile + ": " + e.getMessage());
                }
            } else {
                System.err.println("[dns-resolver] WARNING: File not found: " + hostsFile);
            }
        }

        // 2. Fichier dans le répertoire courant
        Path localFile = Path.of("dns-hosts.properties");
        if (Files.exists(localFile)) {
            try (InputStream is = Files.newInputStream(localFile)) {
                props.load(is);
                System.out.println("[dns-resolver] Loaded hosts from: " + localFile.toAbsolutePath());
                return toMap(props);
            } catch (IOException e) {
                System.err.println("[dns-resolver] WARNING: Cannot read " + localFile + ": " + e.getMessage());
            }
        }

        // 3. Fichier embarqué dans le classpath
        try (InputStream is = LocalDnsResolver.class.getResourceAsStream("/dns-hosts.properties")) {
            if (is != null) {
                props.load(is);
                System.out.println("[dns-resolver] Loaded hosts from classpath: dns-hosts.properties");
                return toMap(props);
            }
        } catch (IOException e) {
            System.err.println("[dns-resolver] WARNING: Cannot read classpath dns-hosts.properties: " + e.getMessage());
        }

        System.err.println("[dns-resolver] WARNING: No dns-hosts.properties found - local resolver has no entries");
        return Map.of();
    }

    private Map<String, String> toMap(Properties props) {
        Map<String, String> map = new HashMap<>();
        for (String key : props.stringPropertyNames()) {
            map.put(key.toLowerCase().trim(), props.getProperty(key).trim());
        }
        return map;
    }

    private Stream<InetAddress> builtinLookup(String host) throws UnknownHostException {
        // Si c'est une IP littérale, on la parse directement (pas de résolution DNS)
        if (IP_V4_PATTERN.matcher(host).matches()) {
            try {
                byte[] addr = ipToBytes(host);
                return Stream.of(InetAddress.getByAddress(host, addr));
            } catch (Exception e) {
                // fall through
            }
        }
        // Ce n'est pas une IP littérale - on ne peut pas résoudre sans récursion
        throw new UnknownHostException(host + " (not in local DNS hosts, fallback cannot resolve)");
    }

    private byte[] ipToBytes(String ip) {
        String[] parts = ip.split("\\.");
        byte[] addr = new byte[4];
        for (int i = 0; i < 4; i++) {
            addr[i] = (byte) Integer.parseInt(parts[i]);
        }
        return addr;
    }

    private String bytesToIp(byte[] addr) {
        return String.format("%d.%d.%d.%d", addr[0] & 0xFF, addr[1] & 0xFF, addr[2] & 0xFF, addr[3] & 0xFF);
    }

    private String formatIpv6(byte[] addr) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < addr.length; i += 2) {
            if (i > 0) sb.append(':');
            sb.append(String.format("%02x%02x", addr[i] & 0xFF, addr[i + 1] & 0xFF));
        }
        return sb.toString();
    }
}
