#script (python)
"""
Color propagator: show atoms in color, depending of their propagation.

Use colorama (see https://pypi.python.org/pypi/colorama)
for coloration in terminal.
Blessing would have been used for terminal cleaning if it worked.

"""


import os
import shutil
import textwrap
from time import sleep
from collections import defaultdict
import colorama  # term colors
from colorama import Fore, Back
colorama.init()  # for windows


SPEED = 0.5
TERM_WIDTH = shutil.get_terminal_size().columns
def clear(): os.system('cls' if os.name == 'nt' else 'clear')


class ColorPropagator:
    def init(self, init):
        self.sleep = SPEED
        self.__symbols = defaultdict(set)
        for atom in init.symbolic_atoms:
            lit = init.solver_literal(atom.literal)
            init.add_watch(lit)
            self.__symbols[lit].add(atom.symbol)

    def propagate(self, ctl, changes):
        # print('PROPAGATE:', changes)
        self.print_atoms(ctl.assignment, changes=changes)

    def undo(self, solver_id, assign, undo):
        # print('     UNDO:', undo)
        self.print_atoms(assign, changes=undo)

    def print_atoms(self, assignment, changes):
        clear()
        changes = frozenset(changes)  # speedup lookup
        assert all(change in self.__symbols for change in changes)
        to_print = ''
        for idx, (lit, atoms) in enumerate(self.__symbols.items(), start=1):
            atom = ';'.join(map(str, atoms))
            assert assignment.has_literal(lit)
            # help(assignment)
            fore, back = Fore.WHITE, Back.BLACK
            if assignment.value(lit) is not None:
                assert assignment.is_true(lit) or assignment.is_false(lit)
                fore = Fore.GREEN if assignment.is_true(lit) else Fore.RED
                if lit in changes: back = Back.WHITE
            elif lit in changes:  # in case of undo: not assigned by in changes
                back = Back.BLUE
            else:
                pass
            to_print += fore + back + atom + Fore.RESET + Back.RESET + '  '
        print('\n\n' + '\n'.join(textwrap.wrap(to_print, width=TERM_WIDTH)))
        sleep(self.sleep)


def main(prg):
    prg.register_propagator(ColorPropagator())
    prg.ground([("base", [])])
    prg.solve()
    print()

#end.
