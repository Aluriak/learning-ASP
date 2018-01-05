#script (python)
"""
Color propagator: show atoms in color, depending of their propagation.

Use colorama (see https://pypi.python.org/pypi/colorama)
for coloration in terminal.
Blessing would have been used for terminal cleaning if it worked.

"""


import os
from time import sleep
import colorama  # term colors
from colorama import Fore, Back
colorama.init()  # for windows


SPEED = 0.3
ATOM_PER_LINE = 14
def clear(): os.system('cls' if os.name == 'nt' else 'clear')


class ColorPropagator:
    def init(self, init):
        self.sleep = SPEED
        self.__symbols = {}
        for atom in init.symbolic_atoms:
            init.add_watch(init.solver_literal(atom.literal))
            self.__symbols[init.solver_literal(atom.literal)] = atom.symbol

    def propagate(self, ctl, changes):
        self.print_atoms(ctl.assignment, changes=changes)

    def undo(self, solver_id, assign, undo):
        self.print_atoms(assign, changes=undo)

    def print_atoms(self, assignment, changes):
        clear()
        changes = frozenset(changes)  # speedup lookup
        assert all(change in self.__symbols for change in changes)
        for idx, (lit, atom) in enumerate(self.__symbols.items(), start=1):
            assert assignment.has_literal(lit)
            if assignment.value(lit) is not None:
                color = Fore.GREEN if assignment.is_true(lit) else Fore.RED
                color += (Back.WHITE if lit in changes else '')
                print(color + str(atom) + Fore.RESET + Back.RESET, end='  ')
            elif lit in changes:  # in case of undo: not assigned by in changes
                print(Back.BLUE + str(atom) + Back.RESET, end='  ')
            else:
                print(str(atom), end='  ')
            if idx % ATOM_PER_LINE == 0:
                print()
        print('\n\n', flush=True)
        sleep(self.sleep)


def main(prg):
    prg.register_propagator(ColorPropagator())
    prg.ground([("base", [])])
    prg.solve()
    print()

#end.
