-module(setup).
-export([set_players/1]).
% -record(options, {mode}).

set_players(1) -> #{player1 => human,   player2 => human};
set_players(2) -> #{player1 => human,   player2 => computer};
set_players(3) -> #{player1 => computer,player2 => computer}.





% ask_for_mode() -> 


