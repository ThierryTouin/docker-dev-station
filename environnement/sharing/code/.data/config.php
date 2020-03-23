<?php
$VERSION   = "1.1d";
$LANG      = "fr";		// voir dossier msg pour les autres langues disponibles
$CHARSET   = "utf-8";
$ROOT      = "/";		// dossier racine de QDRep
$CREATDIR  = 1;			// 0/1 : autorise la création de dossiers
$CREATFILE = 1;			// 0/1 : autorise le téléversement de fichiers
$AUTOLOCK  = 0;			// 0/1 : interdit les droits ci-dessus lors de la création de dossiers par l'admin
$MAXFILE   = 2000000;	// taille max des fichiers téléversés (en octets)
$TIMEOUT   = 15;		// affichage logo "update" si date fichier < $TIMEOUT (en jours)

// les IP autorisées à posséder les droits étendues
$PASSWD    = Array("78.231.60.15", "127.0.0.1");
?>