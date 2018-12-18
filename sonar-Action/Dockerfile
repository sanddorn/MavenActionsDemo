FROM maven:3-jdk-10

LABEL "com.github.actions.name"="Sonarqube"
LABEL "com.github.actions.description"="Check a maven project and report the result. Will fail, if result is not success"
LABEL "com.github.actions.icon"="mic"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="https://github.com/sanddorn/ActionsTest"
#LABEL "homepage"="http://github.com/actions"
LABEL "maintainer"="Nils Bokermann <nils.bokermann+github@bermuda.de>"

WORKDIR /

CMD apt-get -y update && apt-get -y upgrade && apt-get install python3 pip3

COPY sonar.sh sonarqube-result.py /
RUN chmod a+x /sonar.sh /sonarqube-result.py

ENTRYPOINT /bin/sh
