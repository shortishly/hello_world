# Hello World using BEAM Docker Release Action

![main](https://github.com/shortishly/hello_world/actions/workflows/main.yml/badge.svg)


This is an example of a [GitHub
workflow](https://docs.github.com/en/actions/using-workflows) using
the [BEAM Docker Release
Action](https://github.com/shortishly/beam-docker-release-action) to
package a BEAM release as a Docker Image that is from [scratch](https://docs.docker.com/develop/develop-images/baseimages/#create-a-simple-parent-image-using-scratch).

The [workflow](https://github.com/shortishly/hello_world/blob/main/.github/workflows/main.yml) is as follows:

```yaml
on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2
      - name: Build
        run: make
      - name: Beam Docker Relase
        uses: shortishly/beam-docker-release-action@v1.17
        with:
          registry: ghcr.io
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}
```

On every push to the repository, the GitHub workflow will:
- Check out the source code using GitHub's [checkout action](https://github.com/actions/checkout)
- Build the application using `make` creating a BEAM release
- The `beam-docker-release-action` then creates a docker image and
  pushes it to the GitHub container repository
  
The built package can be found [here](https://github.com/shortishly?tab=packages&repo_name=hello_world).

The application includes a simple
[cowboy](https://github.com/ninenines/cowboy) "Hello World!" resource
to show the container working.

To run the container locally on docker:

```shell
docker run -d -p 8080:80 --rm ghcr.io/shortishly/hello_world:0.1.0
```

Once running:

```shell
curl -i http://localhost:8080/
```

Will result in:

```
HTTP/1.1 200 OK
content-length: 13
content-type: text/plain
date: Mon, 07 Feb 2022 16:51:50 GMT
server: Cowboy

Hello world!
```
