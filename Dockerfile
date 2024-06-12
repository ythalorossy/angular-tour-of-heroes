FROM node:18.20.0 as build

WORKDIR /app

COPY package*.json ./

RUN npm install

RUN npm install -g @angular/cli

COPY . .

RUN ng build

FROM nginx:latest

COPY --from=build app/dist/browser /usr/share/nginx/html

EXPOSE 80

# CMD ["ng", "serve", "--host", "0.0.0.0"]