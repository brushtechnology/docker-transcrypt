FROM python:3.6-alpine as builder
RUN apk update && apk add --no-cache ca-certificates git build-base bash
RUN pip install pex
RUN git clone --depth=1 https://github.com/brushtechnology/Transcrypt.git /git-transcrypt
WORKDIR /git-transcrypt
RUN pex . -o /transcrypt --python=python3.6 -c transcrypt 

FROM python:3.6-alpine
COPY --from=builder /transcrypt /transcrypt
WORKDIR /
CMD ["/transcrypt"]