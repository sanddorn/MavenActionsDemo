FROM maven:3-jdk-10

WORKDIR /

COPY secret.sh /
RUN chmod a+x /secret.sh

ENTRYPOINT /bin/sh
