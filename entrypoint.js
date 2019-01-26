#!/usr/bin/env node

const ghpages = require("gh-pages");

const {
  GITHUB_PERSONAL_ACCESS_TOKEN: token,
  SOURCE_DIRECTORY: sourceDir = "build",
  GIT_USER: gitUser = "Automated Github Action",
  GIT_EMAIL: gitEmail = "<>",
  GIT_COMMIT_MESSAGE: commitMessage = "Auto-generated commit",
  GITHUB_REPOSITORY: githubRepository,
} = process.env;

if (!token) {
  console.error("Error: Environment variable GITHUB_PERSONAL_ACCESS_TOKEN must be provided.")
  process.exit(1);
}

const repoUrl = `https://${token}@github.com/${githubRepository}.git`

let opts = [sourceDir, {
  repo: repoUrl,
  message: commitMessage,
  silent: true,
  user: {
    name: gitUser,
    email: gitEmail,
  },
}];

ghpages.publish(sourceDir, {
  repo: repoUrl,
  message: commitMessage,
  silent: true,
  user: {
    name: gitUser,
    email: gitEmail,
  },
}, (error) => {
  if (error) {
    console.error(`Error: ${error}`);
  } else {
    console.log(`Published to gh-pages on ${githubRepository}.`)
  }
});