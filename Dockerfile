FROM golang:1.14
COPY . /build
WORKDIR /build
RUN make build-linux

FROM alpine:latest
COPY --from=0 /build/build/daguerreFlag.amd64 /app/daguerreFlag
CMD ["/app/daguerreFlag"]
