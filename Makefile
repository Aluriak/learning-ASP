CLINGO=~/bin/clingo/clingo
CLINGO=~/bin/clingo

sevenwonders:
	$(CLINGO) sevenwonders.lp

sound:
	$(CLINGO) sound.lp

sums:
	$(CLINGO) sums.lp

ssp:
	$(CLINGO) ssp_integer.lp -n 0
