FROM alpine:latest

RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python

WORKDIR /code

COPY funapp.py .

# We're using ENTRYPOINT where all arguments to `docker run <image>` will be
# passed to whatever is specified by the ENTRYPOINT.
ENTRYPOINT [ "python", "./funapp.py"]

