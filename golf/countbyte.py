
import sys
assert(len(sys.argv) > 1)

for filename in sys.argv[1:]:
    try:
        with open(filename) as fd:
            result = str(len([c for line in fd for c in line])) + ' bytes'
    except FileNotFoundError:
        result = 'not found'

    print(filename + ': ' + str(result))

