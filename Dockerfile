# Stage 1: Build
FROM golang:1.20-alpine AS builder

WORKDIR /app

# Không cần copy go.mod nếu không dùng module
COPY . .

# Build app
RUN go build -o main .

# Stage 2: Run
FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/main .

CMD ["./main"]
