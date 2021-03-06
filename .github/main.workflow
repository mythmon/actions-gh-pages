workflow "Build and Publish" {
  on = "push"
  resolves = "Docker Publish"
}

action "Docker Lint" {
  uses = "docker://replicated/dockerfilelint"
  args = ["Dockerfile"]
}

action "Build" {
  uses = "actions/docker/cli@master"
  args = "build -t gh-pages ."
}

action "Docker Tag" {
  needs = ["Build", "Docker Lint"]
  uses = "actions/docker/tag@master"
  args = "gh-pages mythmon/gh-pages --no-latest"
}

action "Publish Filter" {
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "Docker Login" {
  needs = ["Publish Filter"]
  uses = "actions/docker/login@master"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "Docker Publish" {
  needs = ["Docker Tag", "Docker Login"]
  uses = "actions/docker/cli@master"
  args = "push mythmon/gh-pages"
}
