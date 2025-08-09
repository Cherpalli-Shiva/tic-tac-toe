FROM node:20-alpine AS builder

# Set working directory
WORKDIR /app

# Install dependencies
COPY package.json package-lock.json* ./
RUN npm install

# Copy source code
COPY . .

# Build the app
RUN npm run build

# --- Production stage ---
FROM nginx:alpine AS production

# Copy built assets from builder
COPY --from=builder /app/dist /usr/share/nginx/html

# Copy custom nginx config if you have one (uncomment if needed)
# COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]