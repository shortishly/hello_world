%% Copyright (c) 2012-2022 Peter Morgan <peter.james.morgan@gmail.com>
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%% http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.


-module(hello_world_app).


-behaviour(application).
-export([prep_stop/1]).
-export([start/2]).
-export([stop/1]).
-include_lib("kernel/include/logger.hrl").


start(Type, Args) ->
    ?LOG_DEBUG(#{type => Type, args => Args}),

    try
        {ok, Sup} = hello_world_sup:start_link(),
        {ok, Sup, #{listeners => [start_http(http)]}}
    catch
        _:Reason ->
            {error, Reason}
    end.


prep_stop(#{listeners := Listeners} = State) ->
    ?LOG_DEBUG(#{state => State}),
    lists:foreach(fun cowboy:stop_listener/1, Listeners),
    State;

prep_stop(State) ->
    ?LOG_DEBUG(#{state => State}),
    State.


stop(State) ->
    ?LOG_DEBUG(#{state => State}),
    ok.

start_http(Prefix) ->
    {ok, _} = cowboy:start_clear(
                Prefix,
                [{port, hello_world:get_env(port)}],
                #{env => dispatch(Prefix)}),
    Prefix.

dispatch(Prefix) ->
    #{dispatch => cowboy_router:compile(resources(Prefix))}.


resources(http) ->
    [{'_', [{<<"/">>, hello_world_resource, []}]}].
