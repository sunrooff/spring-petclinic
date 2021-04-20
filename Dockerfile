FROM openjdk:latest
ADD /target/spring-petclinic-2.4.2.jar petclinic.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "petclinic.jar"]
