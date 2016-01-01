
    import sys
    assert(len(sys.argv) == 2)
    filin = sys.argv[1]

    def asp_str(v):
        return ('"' + str(v) + '"') if v not in '1234' else str(v)

    with open(filin) as fd, open('board.lp', 'w') as fo:
            [fo.write('b('+ str(x) +','+ str(y) +','+ asp_str(v) +').\n')
             for y, line in enumerate(fd)
             for x, v in enumerate(line) if v not in ' .\n'
            ]


