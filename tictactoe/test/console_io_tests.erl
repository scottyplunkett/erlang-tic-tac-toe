-module(console_io_tests).
-include_lib("eunit/include/eunit.hrl").

display_test() 	     -> [{ "displays some message in the console",	
			   ?assertEqual(console_io:display("Some Message"),io:fwrite("Some Message")),
			   ?assertEqual(console_io:display(instructions:greet()),io:fwrite("Welcome to TicTacToe\n"))}].

display_board_test() -> [{ "displays a board with a row printed on each line",
		           ?assertEqual(console_io:display_board([1]),board)}].

greet_user_test()    -> [{ "greets a user in console",
			   ?assertEqual(console_io:greet_user(),io:fwrite(instructions:greet()))}].

get_move_test()      -> [{ "ask a user where they would like to move and passes their input",
      			   ?assertEqual(console_io:get_move(),io:fread(instructions:ask_for_move(),"~s"))}].

validate_move_format_test() 
		     -> [{ "formats user's move",
			   ?assertEqual(1,console_io:validate_move_format({ok,["1"]})),
			   ?assertEqual(invalid, console_io:validate_move_format({ok,["G"]}))}].

prompt_test() 	     -> [{ "displays a prompt and awaits input",
		    	   ?assertEqual(console_io:prompt("Some prompt"),io:fread("Some Prompt\n","~s"))}].
