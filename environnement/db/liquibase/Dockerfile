FROM liquibase/liquibase

# COPY changelog.xml /liquibase/changelog.xml
# COPY liquibase.properties /liquibase/liquibase.properties
# COPY data /liquibase/data

ENTRYPOINT ["liquibase", "--changeLogFile=/liquibase/changelog.xml", "update"]