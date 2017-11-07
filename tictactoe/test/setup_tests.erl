-module(setup_tests).
-include_lib("eunit/include/eunit.hrl").

set_players_test() ->
  TestHvH = setup:set_players(1),
  TestHvC = setup:set_players(2),
  [{  "sets the mode for a game to Human v Human, or Human v Computer",
      ?assertEqual([human,human],maps:get(players, TestHvH)),
      ?assertEqual([human,computer],maps:get(players, TestHvC))}].

% get_mode_test() ->
%   TestOptionsRec = test_options_h_v_h#mode
%   [{  "gets the mode for a game",
%       ?assertEqual([human,human], ),
%       ?assertEqual([human,computer],TestHvC)}].
      