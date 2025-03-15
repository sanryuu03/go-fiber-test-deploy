# Build stage
FROM golang:1.23.2-alpine AS builder

# Set working directory
WORKDIR /app

# Install dependencies
RUN apk add --no-cache git

# Copy go mod files
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy source code
COPY . .

# Build the application
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

# Final stage
FROM alpine:3.20

# Set working directory
WORKDIR /app

# Install necessary runtime dependencies
RUN apk --no-cache add ca-certificates tzdata netcat-openbsd && \
    cp /usr/share/zoneinfo/Asia/Jakarta /etc/localtime && \
    echo "Asia/Jakarta" > /etc/timezone

# Copy the binary from builder
COPY --from=builder /app/app .

# Expose the application port (adjust as needed)
EXPOSE 8080

# Run the application
CMD ["./app"]