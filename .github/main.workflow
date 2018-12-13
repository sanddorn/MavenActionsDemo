workflow "New workflow" {
  on = "push"
  resolves = ["Quality Check"]
}

action "compile" {
  uses = "docker://maven:3-jdk-10"
  runs = "mvn clean install"
}

action "Quality Check" {
  uses = "docker://maven:3-jdk-10"
  needs = ["compile"]
  runs = "mvn sonar:sonar"
}
