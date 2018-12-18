workflow "New workflow" {
  on = "push"
  resolves = [
    "Quality Check",
    "compile",
    "./Secret-testAction",
  ]
}

action "compile" {
  uses = "docker://maven:3-jdk-10"
  runs = "mvn clean install"
}

action "Quality Check" {
  uses = "./sonar-Action"
  runs = "./sonar.sh"
  secrets = ["SONAR_TOKEN"]
}

action "./Secret-testAction" {
  uses = "./Secret-testAction"
  secrets = ["SECRET"]
  runs = "/secret.sh"
}
