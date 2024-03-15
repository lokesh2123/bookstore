FROM tomcat:9.0.50
LABEL maintainer "mr.shabuddinshaik@gmail.com"
COPY target/*.war /opt/tomcat/webapps/
