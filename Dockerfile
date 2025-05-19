# Stage 1: Build
FROM golang:1.22-alpine AS builder

# Cài thêm git & ca-certificates để go mod tidy không lỗi khi cần tải dependency
RUN apk --no-cache add git ca-certificates

WORKDIR /app

# Copy go.mod và go.sum trước để cache dependency
COPY go.mod go.sum ./
RUN go mod download

# Copy toàn bộ source code
COPY . .

# Chạy tidy để dọn dẹp và đảm bảo các dependency đã đúng
RUN go mod tidy

# Build app ra file binary tên main
RUN go build -o main .

# Stage 2: Run (image chạy cực nhẹ)
FROM alpine:latest

# Cài ca-certificates để tránh lỗi HTTPS khi call API
RUN apk --no-cache add ca-certificates

WORKDIR /app

# Copy binary từ stage build
COPY --from=builder /app/main .

# Chạy app
CMD ["./main"]
