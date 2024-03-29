# Hello World using BEAM docker release GitHub action


This is an example of a [GitHub workflow][github-workflow] using the
[BEAM docker release action][beam-docker-release-action] to package a BEAM
release as a Docker Image that is from [scratch][scratch].

The [BEAM docker release action][beam-docker-release-action] has support for:

- [Elixir][elixir] with the [Phoenix Framework][phoenix] using [mix][mix] to build;
- [Erlang/OTP][erlang] with [erlang.mk][erlang-mk];
- [Erlang/OTP][erlang] with [rebar3][rebar3]

This repository has 3 branches, showing support for:

- [Elixir with Phoenix][hello-world-elixir-phx]
- [Erlang/OTP with erlang.mk][hello-world-erlang-mk]
- [Erlang/OTP with rebar3][hello-world-rebar3]


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
