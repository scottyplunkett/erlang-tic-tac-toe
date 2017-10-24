-module(turn_progression_tests).
-include_lib("eunit/include/eunit.hrl"). 

% progress_test() ->
%   [{ "progresses through a single turn, then recurses, until it receives true from the stop_turning function",
%       ?assertEqual(turn_progression:stop_turning(true, "X"),turn_progression:progress({"X","O"},["X","X","X"]))}].

% gets a move   
send_request_for_move_test() -> 
  [{ "sends dispatch request to a client interface asking for move from player in turn",
    ?assertEqual(turn_progression:send_request_for_move(console_io),console_io:get_move())}].

% validates a move
validate_move_test() -> 
  [{  "ensures a move is valid before placing a move on a board",
      ?assertEqual(true, turn_progression:validate_move({9,"Piece",[1,2,3,4,5,6,7,8,9]}))}].

% places move on the board 
place_marker_test() ->
  {{  "places a marker on the board",
      ?assertEqual(store:store_move(6, "X", [1,2,3,4,5,6,7,8,9]),turn_progression:place_marker(6, "X", [1,2,3,4,5,6,7,8,9]))}}.

% checks for end conditions 


% exits if game is over 
stop_turning_test() -> 
  [{ "stops turning when game is over & passes a tuple with game information",
     ?assertEqual({"end condition","winner"}, turn_progression:stop_turning(true,{"end condition","winner"})),
     "let's turns continue when game not over & passes a tuple with game info back to main turn function",
     ?assertNotEqual({"end condition","winner"}, turn_progression:stop_turning(false,{"board","players"}))}].
% else 
% switches player order 
switch_player_test() -> 
  [{ "switches the player order", 
      ?assertEqual({"Player2","Player1"},turn_progression:switch_player({"Player1","Player2"}))}].












