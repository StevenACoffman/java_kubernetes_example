FROM openjdk:8-jdk-alpine

# tini and su-exec because both PID 1 and root are special
# --no-cache option preferred over --update
RUN apk add --no-cache su-exec tini

RUN mkdir -p /root/.gradle
ENV HOME /root
# VOLUME /root/.gradle

WORKDIR /app
ADD . /app
# ADD build/ROOT.jar app.jar

# VOLUME /app

EXPOSE 8080
ENV GRADLE_OPTS -Dorg.gradle.native=false
ENV JAVA_OPTS=""

# Set tini as the default entrypoint
ENTRYPOINT ["tini", "--"]
CMD java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app/build/libs/ROOT.jar
