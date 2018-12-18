#! /bin/sh

mvn sonar:sonar -Dsonar.host.url=http://development.bermuda.de/sonar -Dsonar.login=${SONAR_TOKEN}
