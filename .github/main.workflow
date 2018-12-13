workflow "New workflow" {
  on = "push"
  resolves = [
    "Quality Check",
    "Secret-test",
  ]
}

action "compile" {
  uses = "docker://maven:3-jdk-10"
  runs = "mvn clean install"
}

action "Quality Check" {
  uses = "docker://maven:3-jdk-10"
  needs = ["Secret-test"]
  runs = "mvn sonar:sonar -Dsonar.host.url=http://development.bermuda.de/sonar -Dsonar.login=$SONAR_TOKEN"
  secrets = ["SONAR_TOKEN"]
}

action "Secret-test" {
  uses = "docker://maven:3-jdk-10"
  needs = ["compile"]
  runs = "echo $SECRET"
  secrets = ["SECRET"]
}
