% Generate unique identifiers for atoms using python script.


% INPUT DATA
atom(a;b;c;d;e).

% Python script
#script(python)
import itertools
gen = itertools.count(1)

def gen_id(obj):
    return next(gen)
#end.

% Associate input data to a unique id.
uid(V,@gen_id(V)):- atom(V).

#show.
#show uid/2.
