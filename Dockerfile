# --- Stage 1: Builder ---
FROM node:18 AS builder

# Set working directory in the builder stage
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to install dependencies
COPY package*.json ./

# Install dependencies (including devDependencies like TypeScript)
RUN npm install express @types/express typescript uuid @types/uuid 


# Copy all source code
COPY . .

# Compile TypeScript to JavaScript
RUN npx tsc


# --- Stage 2: Production Image ---
FROM node:18-alpine AS runner

# Set the working directory for the final stage
WORKDIR /usr/src/app

# Copy only the compiled JavaScript and necessary files from the builder stage
COPY --from=builder /usr/src/app/dist ./dist
COPY --from=builder /usr/src/app/package*.json ./

# Install only production dependencies (no devDependencies)
RUN npm install --only=production

# Expose the port
EXPOSE 3000

# Command to run the application
CMD ["node", "dist/index.js"]

