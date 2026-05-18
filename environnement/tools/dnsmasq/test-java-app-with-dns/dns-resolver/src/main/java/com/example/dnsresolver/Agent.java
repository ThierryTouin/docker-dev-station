package com.example.dnsresolver;

import java.lang.instrument.Instrumentation;

/**
 * Java Agent entry point.
 * Le simple fait d'utiliser -javaagent:dns-resolver.jar ajoute le JAR
 * au system classpath, rendant le SPI InetAddressResolverProvider visible
 * par ServiceLoader depuis java.base.
 */
public class Agent {

    public static void premain(String agentArgs, Instrumentation inst) {
        // Rien à faire ici - le JAR est déjà sur le system classpath
        // grâce à -javaagent:
        System.out.println("[dns-resolver] Agent loaded - custom DNS resolver active");
    }

    public static void premain(String agentArgs) {
        System.out.println("[dns-resolver] Agent loaded - custom DNS resolver active");
    }
}
