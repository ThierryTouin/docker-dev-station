#FROM drupal:10-apache
FROM docker.io/bitnami/drupal:10

## Change user to perform privileged actions
USER 0
RUN install_packages wget

WORKDIR /opt/bitnami/drupal
RUN composer require drupal/eca
RUN composer require drupal/webform

RUN chmod -R a+rwx /opt/bitnami/drupal/modules

## Revert to the original non-root user
USER 1001




