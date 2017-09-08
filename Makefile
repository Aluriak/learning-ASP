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

build_pc:
	$(CLINGO) build-pc.lp -n 0 --parallel-mode=4,split
