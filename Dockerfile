# Use a valid Node.js Alpine image
FROM node:20-alpine AS builder

# Set the working directory
WORKDIR /opt/backend 

# Copy necessary files and install dependencies
COPY package.json ./
COPY *.js ./ 
RUN npm install 

# Use the same Node.js version for the final image
FROM node:20-alpine 

# Create a user and set permissions
RUN addgroup -S expense && adduser -S expense -G expense && \ 
    mkdir /opt/backend && \
    chown -R expense:expense /opt/backend

# Set environment variables
ENV DB_HOST="mysql"

# Set the working directory
WORKDIR /opt/backend 

# Switch to non-root user
USER expense

# Copy files from builder stage
COPY --from=builder /opt/backend /opt/backend/

# Define the startup command
CMD [ "node", "index.js" ]
