% An embedded python script extract words in a ASP-side given file,
%  to produce all associated atoms along their line number and index in the line.
%
% Also shows how to generate multiple atoms with one python function.
%

#script(python)
def _yield_data(fname:str) -> [str]:
    """Yield data found in given file"""
    assert isinstance(fname, str)
    with open(fname) as fd:
        for idx, line in enumerate(fd, start=1):
            for char_idx, char in enumerate(line.split(), start=1):
                yield idx, char_idx, char


def read(filename:str):
    """If input is string, returns all values found in file of given name"""
    if filename.type == filename.type.String:
        return list(_yield_data(filename.string))
    return []  # nothing to yield
#end.


p(L,N,X):- (L,N,X)=@read("sound.lp").
