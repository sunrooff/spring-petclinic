FROM openjdk: latest
ADD target/petclini.jar docker-petclinic-boot.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "docker-petclinic-boot.jar"]
