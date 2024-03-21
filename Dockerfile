# Use Nginx base image
FROM nginx:alpine

# Copy your HTML file into the Nginx server
COPY index.html /usr/share/nginx/html/

# Expose port 80 to allow external access
EXPOSE 80

