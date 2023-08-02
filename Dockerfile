# Use the official Node.js runtime as the base image
FROM node:18 as build

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY package*.json ./

# Install all dependencies
RUN npm install

# Copy the rest of the application
COPY . .

# Build the app
RUN npm run build

# Stage 2
FROM nginx:latest

COPY --from=build /app/dist/threads-app /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
