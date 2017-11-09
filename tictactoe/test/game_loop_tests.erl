-module(game_loop_tests).
-include_lib("eunit/include/eunit.hrl").
complete_turn_test() -> 
  [{  "completes a turn by either starting a new turn or ending the game when won or board full",
      ?assertEqual(console_io:display(utilities:o_wins()),
                   game_loop:complete_turn([o,2,3,o,5,6,o,8,9])),
      ?assertEqual(console_io:display(utilities:x_wins()),
                   game_loop:complete_turn([x,2,3,4,x,6,7,8,x])),
      ?assertEqual(console_io:display("Draw!\n"),
                   game_loop:complete_turn([x,o,x,o,x,x,o,x,o]))}].

% human_move_test() -> 
%   [{  "prompts for a human move",
%       ?assert(console_io:get_move() =:= game_loop:human_move())}].

computer_move_test() -> 
  [{  "gets move from ai player",
      ?assertEqual(1,game_loop:computer_move([1,2,3,4,5,6,7,8,9])),
      ?assertEqual(3,game_loop:computer_move([x,x,3,4,o,6,7,8,9]))}].

set_mode_test() -> [{"sets the mode, which corresponds to the player types",
                      ?assertEqual([human,human],   game_loop:set_mode("1")),
                      ?assertEqual([human,computer],game_loop:set_mode("2")),
                      ?assertEqual([computer,computer],game_loop:set_mode("3"))}].





