# Renovate Github Action for Apache Solr

GitHub Action to run Renovate self-hosted for the Apache Solr project. 

This action configuration is forked from https://github.com/renovatebot/github-action. See README file in that project for more details.

See `.github/workflows/renovate.yml` for the workflow and `solr/` folder for custom config.

The bot will commit as user `SolrBot <solrbot@cominvent.com>`.

## Maintaining

**NOTE**: This is a volunteer community project organized by [@janhoy](https://github.com/janhoy), and not
officially run by the Apache Solr PMC. However, Solr committers can enable/disable and re-configure how and when
the project is scanned by this bot. See `dev-docs/dependency-upgrades.adoc` in the Solr project for details.

If you want to help maintain this bot, start by filing an issue or PR. Solr committers can
ask to be given direct commit access.

Maintenance is mainly limited to once in a while updating the version of renovate, and to maintain `solr/renovate-config.js`.

Also the two secrets `RENOVATE_TOKEN` and `RENOVATE_FORK_TOKEN` needs to be re-generated each year. The first should have commit access to `solrbot` repositories as well as `workflow` permission. The latter should be a generic github token that is allowed to fork the `apache/solr` repo.

### Custom Docker image

The workflows use a custom Docker image `cominvent/renovate:<tag>` (hosted on Docker Hub) rather than
the upstream `ghcr.io/renovatebot/renovate:<tag>` directly. This is needed because the upstream image
ships with Java 25, but Apache Solr's Gradle build enforces Java 21–23 (Gradle 8.10 does not support
Java 25). The custom image pre-installs JDK 21 via `install-tool` so both Renovate's internal Gradle
commands and the `postUpgradeTasks` commands run with a compatible Java version.

**When upgrading the Renovate version:**
1. Build and push a new custom image using `docker/build.sh`:
   ```bash
   cd docker
   ./build.sh --tag <new-version>-full --push
   ```
   This requires Docker Hub push access to `cominvent/renovate` (run by [@janhoy](https://github.com/janhoy)).
2. Update `renovate-version` in `.github/workflows/renovate.yml` and `renovate-9x.yml` to the new tag.

Once Apache Solr upgrades to a version of Gradle that supports Java 25+, the custom image can be
dropped and the workflows can point directly to the upstream image.

## Contributing to PRs filed by this bot

Some dependency upgrades will require further work in Solr before they pass tests.
The PR branches live in [a fork of the apache/solr git repository](https://github.com/solrbot/apache-_-solr), but Solr committers should be able to commit to the PR branch.
