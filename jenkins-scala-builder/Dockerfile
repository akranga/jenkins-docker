FROM akranga/jenkins-java-builder
MAINTAINER Antons Kranga <akranga@gmail.com>

ENV  SBT_VERSION          0.13.9
ENV  SBT_OPTS             "-Xms512M -Xmx1536M -Xss1M -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=256M" 
ENV  SBT_LAUNCHER_MIRROR  https://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch/$SBT_VERSION/sbt-launch.jar
#ENV  SBT_MIRROR           https://dl.bintray.com/sbt/native-packages/sbt/$SBT_VERSION/sbt-$SBT_VERSION.tgz

ADD  $SBT_LAUNCHER_MIRROR /sbt-launch.jar
#ADD  $SBT_MIRROR          /sbt-$SBT_VERSION.tgz
COPY register-sbt.groovy  /register-sbt.groovy
COPY sbt.sh               /usr/local/bin/sbt
COPY start.sh             /start-scala-builder.sh

RUN  chmod u+x /usr/local/bin/sbt && \
     chmod +x /start-scala-builder.sh

ENTRYPOINT ["/start-scala-builder.sh"]
