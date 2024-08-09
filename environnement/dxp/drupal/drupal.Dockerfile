FROM drupal:10-apache

# Installe les dépendances nécessaires
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Change le répertoire de travail
WORKDIR /var/www/html
#WORKDIR /opt/drupal/web

# install drush
RUN composer require drush/drush drupal/core
#ENV PATH="/opt/drupal/web/vendor/bin:${PATH}"
#RUN echo "export PATH=/opt/drupal/web/vendor/bin:$PATH" > /etc/environment
#RUN /opt/drupal/web/vendor/bin/drush --version


# Télécharge et installe les plugins souhaités via Composer
#RUN composer require drupal/token -n
#RUN composer require drupal/pathauto -n
#RUN composer require drush/drush -n
#RUN composer require drupal/eca

# Assure les permissions correctes pour les fichiers
RUN chown -R www-data:www-data sites modules themes

# Copie le fichier settings.php préconfiguré
COPY ./conf/settings.php sites/default/settings.php

# Exécute la commande d'installation de Drupal
# RUN /opt/drupal/web/vendor/bin/drush site:install standard \
#      --account-name=$DRUPAL_ACCOUNT_NAME \
#      --account-pass=$DRUPAL_ACCOUNT_PASS \
#      --site-name=$DRUPAL_SITE_NAME \
#      --db-url=pgsql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST/$POSTGRES_DB \
#      -y






