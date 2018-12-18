FROM maven:3-jdk-10

LABEL "com.github.actions.name"="Sonarqube check and get result"

WORKDIR /

COPY sonar.sh sonarqube-result.py /
RUN chmod a+x /sonar.sh /sonarqube-result.py

ENTRYPOINT /bin/sh
