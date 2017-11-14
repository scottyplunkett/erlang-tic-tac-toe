-module(ai_tests).
-include_lib("eunit/include/eunit.hrl").

get_best_move_test() 
  -> [{ "returns best move possible",
        ?assertEqual(9,ai:get_best_move([x,x,3,4,5,6,o,o,9],o)),
        ?assertEqual(9,ai:get_best_move([x,2,3,4,5,6,o,o,9],x)),
        ?assertEqual(9,ai:get_best_move([x,2,3,4,5,6,o,o,9],o)),
        ?assertEqual(3,ai:get_best_move([x,x,3,4,5,6,o,o,9],x)),
        ?assertEqual(3,ai:get_best_move([x,x,3,4,5,6,7,o,9],o)),
        ?assertEqual(3,ai:get_best_move([x,x,3,4,5,6,7,o,9],x))}].
        
possible_boards_test() 
  -> [{ "makes a list of hypothetical boards after next move",
        ?assertEqual(([[1,2,3,4,5,6,7,8,x],
                       [1,2,3,4,5,6,7,x,9],
                       [1,2,3,4,5,6,x,8,9],
                       [1,2,3,4,5,x,7,8,9],
                       [1,2,3,4,x,6,7,8,9],
                       [1,2,3,x,5,6,7,8,9],
                       [1,2,x,4,5,6,7,8,9],
                       [1,x,3,4,5,6,7,8,9],
                       [x,2,3,4,5,6,7,8,9]]),
                       ai:possible_boards([1,2,3,4,5,6,7,8,9],x)),
        ?assertEqual(([[1,2,3,4,5,6,x,o,x],
                       [1,2,3,4,5,x,7,o,x],
                       [1,2,3,4,x,6,7,o,x],
                       [1,2,3,x,5,6,7,o,x],
                       [1,2,x,4,5,6,7,o,x],
                       [1,x,3,4,5,6,7,o,x],
                       [x,2,3,4,5,6,7,o,x]]),
                       ai:possible_boards([1,2,3,4,5,6,7,o,x],x)),
        ?assertEqual(([[1,2,3,4,5,o,x,o,x],
                       [1,2,3,4,o,6,x,o,x],
                       [1,2,3,o,5,6,x,o,x],
                       [1,2,o,4,5,6,x,o,x],
                       [1,o,3,4,5,6,x,o,x],
                       [o,2,3,4,5,6,x,o,x]]),
                       ai:possible_boards([1,2,3,4,5,6,x,o,x],o)),
        ?assertEqual(([[o,x,o,x,o,o,x,o,x]]),
                       ai:possible_boards([o,x,o,x,o,6,x,o,x],o))}].

score_test() 
  -> Terminal_Board_Won_By_X_3_empties = [x,x,x,o,o,6,o,8,9],
     Terminal_Board_Won_By_O =  [o,o,o,x,x,6,x,8,9],
     Terminal_Board_Drawn    =  [x,o,x,o,x,x,o,x,o],
     [{ "returns a score based on end condition of board",
        ?assertEqual( 10  - ai:count_moves(Terminal_Board_Won_By_X_3_empties),
                            ai:score(Terminal_Board_Won_By_X_3_empties)),
        ?assertEqual(-10  + ai:count_moves(Terminal_Board_Won_By_O),
                            ai:score(Terminal_Board_Won_By_O)),
        ?assertEqual(  0,   ai:score(Terminal_Board_Drawn))}].

minimize_test()
  ->  Terminal_Board_Won_By_X_3_empties = [x,x,x,o,o,6,o,8,9],
      Terminal_Board_Won_By_O_3_empties = [o,o,o,x,x,6,x,8,9],
      Terminal_Board_Drawn    = [x,o,x,o,x,x,o,x,o],
      [{"scores a board as minimizer",
      ?assertEqual(4, ai:minimize(Terminal_Board_Won_By_X_3_empties)),
      ?assertEqual(-4, ai:minimize(Terminal_Board_Won_By_O_3_empties)),
      ?assertEqual(0, ai:minimize(Terminal_Board_Drawn))
      }].

maximize_test()
  ->  Terminal_Board_Won_By_X_3_empties = [x,x,x,o,o,6,o,8,9],
      Terminal_Board_Won_By_O_3_empties = [o,o,o,x,x,6,x,8,9],
      Terminal_Board_Drawn    = [x,o,x,o,x,x,o,x,o],
      [{"scores a board as maximizer",
      ?assertEqual(4, ai:maximize(Terminal_Board_Won_By_X_3_empties)),
      ?assertEqual(-4, ai:maximize(Terminal_Board_Won_By_O_3_empties)),
      ?assertEqual(0, ai:maximize(Terminal_Board_Drawn))
      }].

count_moves_test()
  ->  Board_with_6_moves = [x,x,x,o,o,6,o,8,9],
      Board_with_5_moves = [1,o,o,x,x,6,x,8,9],
      Full_Board_of_9    = [x,o,x,o,x,x,o,x,o],
      [{"counts the moves made on the board",
      ?assertEqual(6, ai:count_moves(Board_with_6_moves)),
      ?assertEqual(5, ai:count_moves(Board_with_5_moves)),
      ?assertEqual(9, ai:count_moves(Full_Board_of_9))
      }].

minimax_value_test()
  ->  
      Board_Not_Won_x_Turn_5_empties = [x,x,3,4,5,6,o,o,9],
      Board_Not_Won_o_Turn_6_empties = [x,2,3,4,5,6,o,o,9],
      Terminal_Board_Won_By_X_3_empties = [x,x,x,o,o,6,o,8,9],
      Terminal_Board_Won_By_O_3_empties = [o,o,o,x,x,6,x,8,9],
      Terminal_Board_Drawn    = [x,o,x,o,x,x,o,x,o],
      [{"uses the board and the player at turn, 
      creates new boards until one reaches a terminal state, 
      then it returns the score based off whether the player is 
      minimizer or maximizer",
      ?assertEqual(4, ai:minimax_value(Terminal_Board_Won_By_X_3_empties, o)),
      ?assertEqual(-4, ai:minimax_value(Terminal_Board_Won_By_O_3_empties, o)),
      ?assertEqual(4, ai:minimax_value(Terminal_Board_Won_By_X_3_empties, x)),
      ?assertEqual(-4, ai:minimax_value(Terminal_Board_Won_By_O_3_empties, x)),
      ?assertEqual(0, ai:minimax_value(Terminal_Board_Drawn, x)),
      ?assertEqual(0, ai:minimax_value(Terminal_Board_Drawn, o)),
      ?assertEqual(-6, ai:minimax_value(Board_Not_Won_o_Turn_6_empties, o)),
      ?assertEqual(-3, ai:minimax_value(Board_Not_Won_o_Turn_6_empties, x)),
      ?assertEqual(-5, ai:minimax_value(Board_Not_Won_x_Turn_5_empties, o)),
      ?assertEqual(5, ai:minimax_value(Board_Not_Won_x_Turn_5_empties, x))}].