FROM debezium/connect:1.9.5.Final
ENV KAFKA_CONNECT_JDBC_DIR=$KAFKA_CONNECT_PLUGINS_DIR/kafka-connect-jdbc

ARG KAFKA_JDBC_VERSION=5.3.1
ARG MYSQL_VERSION=8.0.30

# Deploy MySQL JDBC Driver
RUN cd /kafka/libs && curl -sO https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.30/mysql-connector-java-$MYSQL_VERSION.jar

# Deploy Kafka Connect JDBC
RUN mkdir $KAFKA_CONNECT_JDBC_DIR && cd $KAFKA_CONNECT_JDBC_DIR &&\
   curl -sO https://packages.confluent.io/maven/io/confluent/kafka-connect-jdbc/$KAFKA_JDBC_VERSION/kafka-connect-jdbc-$KAFKA_JDBC_VERSION.jar