# Stage 1: Build
FROM golang:1.22-alpine AS builder

WORKDIR /app

# Copy source code vào container
COPY . .

# Nếu đang dùng module thì đảm bảo go.mod đúng cú pháp (ví dụ: go 1.20)
RUN go mod tidy 

# Build app
RUN go build -o main .

# Stage 2: Run
FROM alpine:latest

WORKDIR /app

# Copy file binary từ builder stage
COPY --from=builder /app/main .

# Lệnh chạy app
CMD ["./main"]
