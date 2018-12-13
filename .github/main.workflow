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
  uses = "docker://maven:3-jdk-10"
  runs = "mvn sonar:sonar -Dsonar.host.url=http://development.bermuda.de/sonar -Dsonar.login=$SONAR_TOKEN"
  secrets = ["SONAR_TOKEN"]
}

action "./Secret-testAction" {
  uses = "./Secret-testAction"
  secrets = ["SECRET"]
  runs = "/secret"
}
