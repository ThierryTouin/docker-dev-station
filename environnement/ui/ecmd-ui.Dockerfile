# Use Node v8.9.0 LTS
FROM node:carbon

# Setup app working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY ./src/package*.json ./

# Install app dependencies
RUN npm install

# Copy sourcecode
COPY ./src .

# Start app
CMD [ "npm", "start" ]