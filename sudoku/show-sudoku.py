"""Show sudoku yield by clingo as s/3 atoms.

usage:
    python show-sudoku.py <file containing clingo output> [answer set to print]

If no answer set number is given, the whole file will be parsed,
allowing you to provide any of the examples in input.

example:
    python show-sudoku.py output.lp 1
    python show-sudoku.py examples/simple.lp
    python show-sudoku.py - 1

The last will read file from stdin.

"""

import re
import sys

ATOM_REG = re.compile(r's\(([0-9]),([0-9]),([0-9])\)')


def read_stdin() -> [str]:
    while True:
        try:
            yield input()
        except EOFError:
            return

def read_file(outfile:str) -> [str]:
    if outfile == '-':
        yield from read_stdin()
    else:
        with open(outfile) as fd:
            yield from fd

def answerset_from_anyfile(outfile:str) -> str:
    return ''.join(read_file(outfile))

def answerset_from_outfile(outfile:str, answerset:int) -> str:
    lines = read_file(outfile)
    while True:
        try:
            line = next(lines)
        except StopIteration:
            break
        if line.startswith('Answer: '):
            if str(int(line[len('Answer: '):])) == str(answerset):
                return next(lines)

def show(atoms:str):
    data = ATOM_REG.findall(atoms)
    grid = {
        (int(x), int(y)): value
        for x, y, value in data
    }
    for row in range(1, 10):
        for col in range(1, 10):
            print('|' + grid.get((row, col), ' '), end='')
            if not col % 3:
                print('|  ', end='')
        print()
        if not row % 3:
            print()


if __name__ == '__main__':
    args = sys.argv[1:]
    if len(args) == 1:
        answerset = answerset_from_anyfile(*args)
    elif len(args) == 2:
        answerset = answerset_from_outfile(*args)
    else:
        print(__doc__)
        exit()

    if answerset:
        show(answerset)
    else:
        print('No answer set found.')
