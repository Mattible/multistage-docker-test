# Stage 1: goLang_Download
FROM golang:alpine as goLang_Download
RUN apk update --no-cache
RUN apk add git --no-cache
WORKDIR /app
ENV GO111MODULE=on
ADD ./go.mod /app/go.mod
ADD ./go.sum /app/go.sum
RUN go mod download

#Stage 2: Packager
FROM golang:alpine as packager
COPY  --from=goLang_Download ./go/pkg/mod /go/pkg/mod
ADD ./ /app
WORKDIR /app
# Build the application for Target Operating System Linux
RUN CGO_ENABLED=0 GOOS=linux go build -o golang-test  .

# Stage 3 
FROM scratch
# Copy just the compiled golang package
COPY --from=packager /app/golang-test /app/golang-test
ENTRYPOINT ["/app/golang-test"]
EXPOSE 8000