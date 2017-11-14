all:
	compile run_test clean

play:
	mkdir ebin
	erlc -o ebin/ src/*.erl
	erlc -o ebin/ test/*.erl
	erl -pa ebin \
	-env ERL_LIBS deps/ \
	-eval 'io:format("\e[H\e[2J").' \
	-eval 'io:format(os:cmd(clear)).' \
	-eval 'io:fread("To begin a game run the command:\n ttt:new().\n and press ENTER...\n","~s")' \
	-s init stop  

compile:
	mkdir ebin
	erlc -o ebin/ src/*.erl
	erlc -o ebin/ test/*.erl

run_test:
	erlc -o ebin/ src/*.erl
	erlc -o ebin/ test/*.erl
	erl -pa ebin \
	-env ERL_LIBS deps/ \
	-eval 'eunit:test("ebin").' \
	-s init stop

clean: 
	rm -rf ebin/*.beam 
	rm -rf erl_crash.dump

