# Hello World using BEAM docker release GitHub action

![main](https://github.com/shortishly/hello_world/actions/workflows/main.yml/badge.svg?branch=erlang-mk)


This is an example of a [GitHub workflow][github-workflow] using the
[BEAM docker release action][beam-docker-release-action] to package a BEAM
release as a Docker Image that is from [scratch][scratch].

The [BEAM docker release action][beam-docker-release-action] has support for:

- [Elixir][elixir] with the [Phoenix Framework][phoenix] using [mix][mix] to build;
- [Erlang/OTP][erlang] with [erlang.mk][erlang-mk];
- [Erlang/OTP][erlang] with [rebar3][rebar3]

This repository has 3 branches, showing support for:

- [Elixir with Phoenix][hello-world-elixir-phx]
- [Erlang/OTP with erlang.mk][hello-world-erlang-mk] (this branch)
- [Erlang/OTP with rebar3][hello-world-rebar3]


When packaging an application as a [docker][docker-com] container it
is too easy to just put `FROM debian` (other distributions are
available, replace `debian` with your distribution of choice). For
sure it is going to work, but you have just included dozens of
libraries and binaries that your application [just does not
need][dockerfile-best-practices].


This branch uses [erlang.mk][erlang-mk] to build an [Erlang/OTP][erlang]
with a [Cowboy][cowboy] example application into a release.

The [workflow][workflow] is as follows:

```yaml
---
on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Beam Docker Release
        uses: shortishly/beam-docker-release-action@v1.23
        with:
          registry: ghcr.io
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}
          build-image: erlang:25.1
          build-platforms: linux/amd64
          build-tags: ghcr.io/${{ github.repository }}:erlang.mk
```

The [BEAM docker release GitHub action][beam-docker-release-action]
uses a [multi-stage build][docker-building-multi-stage] that:

- Builds the release using make via [erlang.mk][erlang-mk];
- Copies only the release and its runtime dependencies into a
  [scratch base image][baseimages-scratch];
- Login and publish the image to the [GitHub Container Registry (ghcr.io)][ghcr-io] or
  any other container registry.

The parameters used in the BEAM docker release GitHub action [can be
found here][beam-docker-release-action]. Some of the ideas are
described further in this [article][shortishly-eidfs] with the
[dependency copying script][beam-docker-release-mkimage] now written
as an [escript][escript] to support both [Erlang/OTP][erlang] and
[Elixir][elixir]. This [article][shortishly-elixir-bdra] looks at
using [Elixir][elixir] with the BEAM docker release action.

To run the container:

```shell
docker run \
    --detached \
    --publish 8080:80 \
    --rm \
    ghcr.io/shortishly/hello_world:erlang.mk
```

Then:

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

[baseimages-scratch]: https://docs.docker.com/engine/userguide/eng-image/baseimages/
[beam-docker-release-action]: https://github.com/shortishly/beam-docker-release-action
[beam-docker-release-mkimage]: https://github.com/shortishly/beam-docker-release-action/blob/main/bin/mkimage
[cowboy]: https://github.com/ninenines/cowboy
[docker-building-multi-stage]: https://docs.docker.com/build/building/multi-stage/
[docker-com]: https://www.docker.com
[dockerfile-best-practices]: https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#dont-install-unnecessary-packages
[elixir]: https://elixir-lang.org
[erlang-mk]: https://erlang.mk
[erlang]: https://www.erlang.org
[escript]: https://www.erlang.org/doc/man/escript.html
[ghcr-io]: https://ghcr.io/
[github-workflow]: https://docs.github.com/en/actions/using-workflows
[hello-world-elixir-phx]: https://github.com/shortishly/hello_world/tree/elixir-phx
[hello-world-erlang-mk]: https://github.com/shortishly/hello_world/tree/erlang-mk
[hello-world-rebar3]: https://github.com/shortishly/hello_world/tree/rebar3
[hw-packages]: https://github.com/shortishly?tab=packages&repo_name=hello_world
[mix-release]: https://hexdocs.pm/mix/1.14/Mix.Tasks.Release.html
[mix]: https://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html
[phoenix]: https://www.phoenixframework.org
[rebar3]: https://rebar3.org
[scratch]: https://docs.docker.com/develop/develop-images/baseimages/#create-a-simple-parent-image-using-scratch
[shortishly-eidfs]: https://shortishly.com/blog/erlang-in-docker-from-scratch/
[shortishly-elixir-bdra]: https://shortishly.com/blog/elixir-beam-docker-release-action/ 
[workflow]: https://github.com/shortishly/hello_world/blob/erlang-mk/.github/workflows/ci.yml
