# Carp on Docker

To build:

```sh
docker build -t carp .
```

To run the REPL:

```sh
docker run -v "$PWD:/root/app" --rm -it carp:latest
```

To execute directly:

```sh
docker run -v "$PWD:/root/app" --rm -it carp:latest carp -x main.carp
```
