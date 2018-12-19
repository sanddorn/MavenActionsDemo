FROM maven:3-jdk-10

LABEL "com.github.actions.name"="Sonarqube"
LABEL "com.github.actions.description"="Check a maven project and report the result. Will fail, if result is not success"
LABEL "com.github.actions.icon"="mic"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="https://github.com/sanddorn/ActionsTest"
LABEL "maintainer"="Nils Bokermann <nils.bokermann+github@bermuda.de>"


COPY sources.list /etc/apt/
RUN apt-get -y update && apt-get -y upgrade && apt-get -y install python3 python3-pip
RUN pip3 install requests


COPY sonar.sh sonarqube-result.py /
RUN chmod a+x sonar.sh sonarqube-result.py

WORKDIR /

CMD /bin/sh
