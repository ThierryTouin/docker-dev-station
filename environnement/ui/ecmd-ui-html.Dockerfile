# Use Node v8.9.0 LTS
FROM node:carbon

# Setup app working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY ./html-app/package*.json ./

# Install app dependencies
RUN npm install

# Copy sourcecode
COPY ./html-app .

# Start app
CMD [ "npm", "start" ]