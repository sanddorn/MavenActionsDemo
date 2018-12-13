FROM maven:3-jdk-10

COPY secret.sh .
RUN chmod a+x secret.sh

ENTRYPOINT ./secret.sh
