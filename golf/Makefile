CLINGO=clingo


# print the scores for each player
score:
	$(CLINGO) board.lp score.lp --out-atomf="%s. " --verbose=0
golf:
	$(CLINGO) board.lp golf.lp
	#$(CLINGO) board.lp golf.lp --out-atomf="%s. " --verbose=0
count:
	python3 ./countbyte.py golf.lp
save:
	xclip -sel clip < golf.lp


# generate input data from an hex map to atoms (see board file)
conv:
	python3 board2atom.py board



