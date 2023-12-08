# Use the official Ubuntu base image
FROM ubuntu:latest

# Update package lists and install necessary dependencies
RUN apt-get update && \
    apt-get install -y flex bison && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy your Flex and Bison files into the container (assuming they are in the same directory as the Dockerfile)
COPY . .

# Add any other commands needed to build your project

# Specify the command to run your application (replace this with your actual command)
CMD ["/bin/bash"]

