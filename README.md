# GitHub Action to deploy to Github Pages

This Action uses [gh-pages](https://www.npmjs.com/package/gh-pages) to deploy
a static site to Github Pages.

## Usage

An example workflow to build, test, and publish an npm package to the default public registry follows:

```hcl
workflow "Build and Publish" {
  on = "push"
  resolves = ["Publish"]
}

action "Install" {
  uses = "borales/actions-yarn@master"
  args = "install --prod"
}

action "Build" {
  needs = ["Install"]
  uses = "borales/actions-yarn@master"
  args = "build"
}

action "Publish" {
  needs = ["Build"]
  uses = "mythmon/actions-gh-pages@master"
  secrets = ["GITHUB_PERSONAL_ACCESS_TOKEN"]
}
```

### Secrets

* `GITHUB_PERSONAL_ACCESS_TOKEN` - A [Personal Access
  Token](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/).
  Must **not** be the token provided by the workflow editor.

### Environment variables

* `SOURCE_DIRECTORY` - *Optional*. The source directory to publish files
  from. Defaults to `"build"`.
* `GIT_USER` - *Optional*. The user to provide for the git commit. Defaults to
  "Automated Github Action".
* `GIT_EMAIL` - *Optional*. The email to provide for the git commit. Defaults
  to "<>" (no email).
* `GIT_COMMIT_MESSAGE` - *Optional*. The message to provide for the git commit.
  Defaults to "Auto-generated commit".