-module(console_io).
-export([display/1,greet_user/0]).
-import(instructions, [greet/0]).


display(Message) ->
  io:fwrite(Message).

greet_user() -> display(greet()).




