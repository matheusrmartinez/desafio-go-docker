# Stage 1: Build
FROM golang:alpine AS builder

WORKDIR /usr/src/hello

# Copy all files from the current directory to the PWD(Present Working Directory) inside the container
COPY . .

# Build the Go app
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app hello.go

# Stage 2: Run
FROM scratch

COPY --from=builder /usr/src/hello/app /app

# Command to run
ENTRYPOINT ["/app"]