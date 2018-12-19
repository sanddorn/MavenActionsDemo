#! /bin/sh
set -e
set -x
SONAR_HOST=http://development.bermuda.de/sonar
export TASKID=$(mvn sonar:sonar \
     -Dsonar.host.url=${SONAR_HOST} \
     -Dsonar.login=${SONAR_TOKEN} | tee | grep task?id= | sed -e's/.*task?id=\(.*\)/\1/')

export RESULT=$(/sonarqube-result.py --token=${SONAR_TOKEN} --Base=${SONAR_HOST}  --task=${TASKID})
if [ x$RESULT != xSUCCESS ]; then
    exit 1
fi
