FROM tomcat:9.0.50
LABEL maintainer "lokesh.devops21@gmail.com"
COPY target/*.war /opt/tomcat/webapps/
