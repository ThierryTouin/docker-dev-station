## Stage 1: Build Image
FROM node:18-alpine as build

ARG TITLE 
ARG TOOLS_LINK
ARG DDS_LINK
ARG OTHER1_LINK

WORKDIR /app
COPY ./react-app/package*.json ./
RUN npm install
COPY ./react-app .
RUN REACT_APP_TITLE=${TITLE} \
    REACT_APP_TOOLS_LINK=${TOOLS_LINK} \
    REACT_APP_DDS_LINK=${DDS_LINK} \
    REACT_APP_OTHER1_LINK=${OTHER1_LINK} \
    npm run build

## Stage 2, use the compiled app, ready for production with Nginx
FROM nginx:1.21.6-alpine
COPY --from=build /app/build /usr/share/nginx/html 
EXPOSE 80 
CMD ["nginx", "-g", "daemon off;"]