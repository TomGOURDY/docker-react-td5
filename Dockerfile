FROM node:16-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm test 
RUN npm run build

FROM nginx:1.23-alpine
WORKDIR /usr/share/nginx/html
COPY --from=prod /app/build .
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]