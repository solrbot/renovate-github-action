ARG RENOVATE_VERSION=43.170.18-full
FROM ghcr.io/renovatebot/renovate:${RENOVATE_VERSION}

# Pre-install JDK 21 so Renovate's internal Gradle commands work with projects
# that enforce Java 21-23 (e.g. Solr with Gradle 8.10 which doesn't support JDK 25)
USER root
RUN rm -rf /tmp/renovate
USER ubuntu
RUN install-tool java 21.0.11+10.0.LTS
