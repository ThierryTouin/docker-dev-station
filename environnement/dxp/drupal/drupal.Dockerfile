FROM drupal:10-apache 

ENV DEBIAN_FRONTEND=noninteractive

RUN composer require drush/drush -n
RUN composer require drupal/eca -n

