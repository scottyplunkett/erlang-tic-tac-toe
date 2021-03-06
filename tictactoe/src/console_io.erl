-module(console_io).
-export([display/1,display_board/1,greet_user/0,get_move/0,validate_move_format/1,prompt/1]).

display(Message) -> io:fwrite(Message). 

display_board([]) 			    
	-> board;
display_board([FirstToPrint | [NextToPrint | [LastToPrint | LeftToPrint]]]) 
	-> io:format("~w~n",[[FirstToPrint, NextToPrint, LastToPrint]]),
  	 display_board(LeftToPrint).
  
greet_user() -> display(instructions:greet()).

prompt(MessageToClient) -> io:fread(MessageToClient++"\n","~s").

get_move() -> prompt(instructions:ask_for_move()).

validate_move_format(Move) when is_integer(Move) -> Move;
validate_move_format({ok,[Move]}) 
	-> try list_to_integer(Move) of 
          _ -> list_to_integer(Move)
  	 catch 
          error:badarg -> invalid 
      end.

