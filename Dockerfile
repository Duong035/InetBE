# Build stage
FROM golang:1.20-alpine AS builder

WORKDIR /app
COPY . .

RUN go build -o main .

# Final image
FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/main .

CMD ["./main"]
