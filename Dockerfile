############################################################
# Dockerfile to build MongoDB container images
# Based on debian 10
############################################################

# Set the base image to DEbian Buster
FROM node:14.2-buster

# File Author / Maintainer
MAINTAINER Kevin LOPES

################# BEGIN INSTALLATION ######################
# Install MongoDB Following the Instructions at MongoDB Docs
# Ref: https://docs.mongodb.com/manual/tutorial/install-mongodb-on-debian/
RUN apt-get update && apt-get install -y gnupg curl

# # Add the package verification key
# RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add -
RUN curl https://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add -

# # Add MongoDB to the repository sources list
RUN echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/4.2 main" | tee /etc/apt/sources.list.d/mongodb-org-4.2.list

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -

# # Update the repository sources list once more & Install MongoDB package (.deb)
RUN apt-get update && apt-get install -y mongodb-org
# Create the default data directory
RUN mkdir -p /data/menus

COPY . src/
WORKDIR /src

##################### INSTALLATION END #####################

# Expose the default port
EXPOSE 27017
EXPOSE 8080

RUN npm install && npm run build

# Set default container command
ENTRYPOINT ["/src/entrypoint.sh"]
