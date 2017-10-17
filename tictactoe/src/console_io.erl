-module(console_io).
-export([display/1,display_board/1,greet_user/0,get_move/0,get_marker/0,prompt/1]).


display(Message) ->
  io:fwrite(Message). 

display_board([]) -> board;
display_board([RowToPrint | RemainingRows]) ->
	io:format("~w~n",[RowToPrint]),
	display_board(RemainingRows).

greet_user() -> display(instructions:greet()).

get_move() -> prompt(instructions:ask_for_move()).

get_marker() -> prompt(instructions:ask_for_marker()).

prompt(MessageToClient) -> 
  io:fread(MessageToClient++"\n","~s").

