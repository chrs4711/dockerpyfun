FROM alpine:latest

RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python

WORKDIR /code

COPY funapp.py .

CMD [ "python", "./funapp.py" ]

