module.exports = {
  gitAuthor: 'SolrBot <solrbot@cominvent.com>',
  onboarding: false,
  requireConfig: "required",
  platform: 'github',
  forkProcessing: "disabled",
  repositories: ['apache/solr'],
  baseBranchPatterns: ["branch_9x"],
  useBaseBranchConfig: "merge",
  allowedCommands: ["./gradlew.*"],
  branchPrefix: "renovate-9x/",
  commitMessageSuffix: " (branch_9x)",
  dryRun: null,
};
