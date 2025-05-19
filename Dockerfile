# Stage 1: Build
FROM golang:1.20-alpine AS builder

WORKDIR /app

# Copy go mod files trước để tận dụng cache layer
COPY go.mod ./
COPY go.sum ./
RUN go mod download

# Copy toàn bộ source code vào container
COPY . .

# Build binary, output thành file 'main'
RUN go build -o main .

# Stage 2: Run
FROM alpine:latest

WORKDIR /app

# Copy binary từ builder stage sang
COPY --from=builder /app/main .

# Mặc định chạy file main
CMD ["./main"]
