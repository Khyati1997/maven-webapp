# Use the official Tomcat image as the base image
FROM tomcat:9.0

# Set the working directory inside the container
WORKDIR /usr/local/tomcat/webapps/

# Ensure the container has the latest updates and clean up unnecessary files
RUN apt-get update && apt-get clean

# Copy the generated WAR file into the Tomcat webapps directory
COPY target/maven-webapp.war ./ROOT.war

# Set proper permissions for the copied file
RUN chmod 644 ROOT.war

# Expose port 8080 for Tomcat
EXPOSE 8080

# Health check to ensure the app is running
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s \
  CMD curl -f http://localhost:8080 || exit 1

# Start Tomcat
CMD ["catalina.sh", "run"]
