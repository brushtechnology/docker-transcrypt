FROM python:3.6-alpine as builder
RUN apk add --no-cache ca-certificates git build-base bash && \
    pip install pex && \
    git clone --depth=1 https://github.com/brushtechnology/Transcrypt.git /git-transcrypt
WORKDIR /git-transcrypt
RUN pex . -o /transcrypt --python=python3.6 -c transcrypt 

FROM python:3.6-alpine
COPY --from=builder /transcrypt /transcrypt
WORKDIR /
CMD ["/transcrypt"]