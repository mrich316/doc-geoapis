FROM node:8-stretch AS build-image

# Fix a layer with dependencies
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install

# Copy all files and build.
COPY . .
RUN npm run build

FROM nginx:mainline
COPY --from=build-image /app/bundle.js /app/index.html /usr/share/nginx/html/
COPY --from=build-image /app/css /usr/share/nginx/html/css
