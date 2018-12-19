# Sonarqube Action

This is a very simple aproach to a sonarqube quality check. It will check via a maven call and get the actual status of 
the quality gate. If these quality gates were not passed, the action will fail. 

Used as `/sonar.sh` and needs the `SONAR_TOKEN` environment variable to be set.
