FROM node:alpine as builder
WORKDIR "/app"
COPY "package.json" .
RUN npm config set registry https://repo1.uhc.com/artifactory/api/npm/npm-virtual/
RUN npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=0 /app/build /usr/share/nginx/html