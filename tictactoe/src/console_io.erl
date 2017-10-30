-module(console_io).
-export([ display/1,
	  greet_user/0,
	  display_board/1]).


display(Message) ->
  io:fwrite(Message).

display_board([]) -> board;
display_board([RowToPrint | RemainingRows]) ->
	io:format("~w~n",[RowToPrint]),
	display_board(RemainingRows).

greet_user() -> display(instructions:greet()).




