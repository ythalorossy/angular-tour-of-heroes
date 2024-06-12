FROM node:18.20.0 as build

WORKDIR /app

COPY package*.json ./

RUN npm install

RUN npm install -g @angular/cli

COPY . .

RUN ng build

FROM nginx:alpine

COPY --from=build app/dist/browser /usr/share/nginx/html

COPY nginx.conf /etc/nginx/

EXPOSE 9080

CMD ["nginx", "-g", "daemon off;"]