workflow "New workflow" {
  on = "push"
  resolves = ["Quality Check"]
}

action "compile" {
  uses = "docker://maven:3-jdk-10"
  runs = "mvn clean install"
}

action "Quality Check" {
  uses = "./sonar-Action"
  needs = ["compile"]
  runs = "/sonar.sh"
  secrets = ["SONAR_TOKEN"]
}
