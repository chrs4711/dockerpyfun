# Dockerfun cli app

Goal is to have a small cli app and run it via a docker container.
Resons to do this:
* explore what can be done
* perhaps find a way to avoid the packaging and deployment hell that python
  drags you in.

## First try

Found a [tutorial by docker](https://www.docker.com/blog/containerized-python-development-part-1/)

Using the suggested base image `FROM python:3.8` results in an 882MB
sized image:

```
docker images
```

but running it works:

```
docker run --rm -it --name test funimage
```

## Second try

Based on `alpine:latest`, installing python3 into the image with:

```
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
```

Image now has 49MB, this can be worked with.

```
$ docker build -t funimage .
```

Next step: pass cli parameters to the python script within the container.

## Third try: passing cli parameters

[That's how it works:](https://docs.docker.com/engine/reference/builder/#entrypoint)

> Command line arguments to docker run <image> will be appended after all elements in an exec form ENTRYPOINT, and will override all elements specified using CMD

Build the image:

```
$ docker build -t funimage .
```

Run the image with parameters. Parameters `foo` and `bar` will be passed to the 
python script running within the container:

```
$ docker run --rm -it --name test funimage foo bar
```

## Using it as a normal command

Now, to run as if it were a normal command, an alias is needed:

```
$ alias funapp="docker run --rm -it --name test funimage"
```

after that, we can call it with:

```
$ funapp foo bar
>> This is an example app running Python 3.8.5 (default, Jul 20 2020, 23:11:29) 
[GCC 9.3.0]
>> Number of arguments: 3
>> Arguments: ['./funapp.py', 'foo', 'bar']
```

Works, though there's a significant startup lag :/