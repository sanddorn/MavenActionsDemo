#! /bin/sh
set -e
SONAR_HOST=http://development.bermuda.de/sonar
export TASKID=$(mvn sonar:sonar \
     -Dsonar.host.url=${SONAR_HOST} \
     -Dsonar.login=${SONAR_TOKEN} | tee | grep task?id= | sed -e's/.*task?id=\(.*\)/\1/')

echo "Task: ${TASKID}"

export RESULT=$(/sonarqube-result.py --token=${SONAR_TOKEN} --Base=${SONAR_HOST}  --task="${TASKID}")

echo "Result: ${RESULT}"

if [ x$RESULT != xOK ]; then
    echo "RESULT: $RESULT"
    exit 1
fi
