workflow "New workflow" {
  on = "push"
  resolves = ["compile"]
}

action "compile" {
  uses = "docker://maven:3-jdk-10"
  runs = "mvn clean install"
}
