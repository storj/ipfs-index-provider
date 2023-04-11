FROM golang:1.19 as build
WORKDIR /index-provider
RUN go install github.com/ipni/index-provider/cmd/provider@8d13e46

COPY . /index-provider

FROM alpine:3.17.3
RUN apk add gcompat jq

COPY --from=build /go/bin/provider /usr/local/bin
COPY --from=build /index-provider/container_daemon /usr/local/bin/start_provider

# Create the fs-repo directory and switch to a non-privileged user.
ENV PROVIDER_PATH /data/provider
RUN mkdir -p $PROVIDER_PATH

# Expose the fs-repo as a volume.
VOLUME $PROVIDER_PATH

# Fix permissions on start_provider (ignore the build machine's permissions)
RUN chmod 0755 /usr/local/bin/start_provider

ENTRYPOINT ["start_provider"]