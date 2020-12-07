FROM node:10.15.3 as source
WORKDIR /src/RegionSouthDenmark
COPY package.json ./
RUN npm install
COPY . ./
RUN npm run build

FROM nginx:1.15.9
WORKDIR /opt/RegionSouthDenmark
COPY --from=source /src/RegionSouthDenmark/dist .
COPY default.template /etc/nginx/conf.d/default.conf
CMD ["nginx", "-g", "daemon off;"]
