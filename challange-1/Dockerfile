FROM openjdk:11.0.7-jre-slim
WORKDIR /home
COPY target/*.jar /home/*.jar
EXPOSE 8080
CMD ["sh", "-c", "java -jar /home/*.jar"]