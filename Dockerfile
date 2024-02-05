# Stage 1: Build the Node.js application
FROM node:14 AS builder

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

# Stage 2: Use Nginx to serve the built application
FROM nginx:alpine

# Copy the build artifacts from the builder stage
COPY --from=builder /usr/src/app/build /usr/share/nginx/html

# Copy your Nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

