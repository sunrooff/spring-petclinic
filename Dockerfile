FROM openjdk:latest
ADD /var/lib/jenkins/workspace/test/target/spring-petclinic-2.4.2.jar petclinic-boot.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "petclinic-boot.jar"]
