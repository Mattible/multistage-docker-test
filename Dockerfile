# Stage 1
FROM golang:alpine as builder

ENV GO111MODULE=on

WORKDIR /app

ADD ./ /app

RUN apk update --no-cache

RUN apk add git --no-cache
# Build the application for Target Operating System Linux
RUN CGO_ENABLED=0 GOOS=linux go build -o golang-test  .

# Stage 2 
FROM scratch
# Copy just the compiled golang package
COPY --from=builder ./app/golang-test /app/golang-test

ENTRYPOINT ["/app/golang-test"]

EXPOSE 8000