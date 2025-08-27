# Set the base image for the new image
FROM jenkins/jenkins:lts-jdk17

# Set the current user to root for privileged operations
USER root

# Update package list and install dependencies
RUN apt-get update && \
    apt-get install -y apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common

# Add Docker's official GPG key and repository (DEBIAN version)
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package list with Docker repo and install Docker
RUN apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io

# Add Jenkins user to Docker group
RUN usermod -aG docker jenkins

# Switch back to Jenkins user for security
USER jenkins