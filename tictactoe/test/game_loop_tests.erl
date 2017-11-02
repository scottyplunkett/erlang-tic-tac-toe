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
