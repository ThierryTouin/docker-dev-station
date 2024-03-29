# Use Node v8.9.0 LTS
FROM node:latest

# Setup app working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY ./react-app/package*.json ./

# Install app dependencies
RUN npm install

# Copy sourcecode
COPY ./react-app .

# Start app
CMD [ "npm", "start" ]