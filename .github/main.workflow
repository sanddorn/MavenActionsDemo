workflow "New workflow" {
  on = "push"
  resolves = [
    "./sonar-Action",
  ]
}

action "compile" {
  uses = "docker://maven:3-jdk-10"
  runs = "mvn clean install"
}

action "./sonar-Action" {
  uses = "./sonar-Action"
  needs = ["compile"]
  runs = "./sonar.sh"
  secrets = ["SONAR_TOKEN"]
}
