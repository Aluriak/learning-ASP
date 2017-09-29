%*
% Program that build a PC using given components.
%
% Takes into account the price, and a user defined 'rate'.
% Some preferences are also tunable, in order to get the perfect build.
%
% Parsing a website selling components in order to get names,
% prices and requirements/incompatibilities is not in the scope of that file.
%
% The file is divided into 5 parts:
%   data: the raw data about components
%   preferences: tunable preferences of user
%   knowledge: domain knowledge about PC building
%   expansion: transform data of 3 previous parts into data for the model
%   model: the engine computing builds
%
% Each output model is a build that costs less than the maximal cost.
% Builds are sorted by increasing rating.
*%

#const max_cost=800.


%%%%%%%%%%%%%%%%
% DATA
%%%%%%%%%%%%%%%%
component(gpu,"A").
price(gpu,"A",330).
rate(gpu,"A",10).

% Another way to write down the info: type, name, price, rate.
component(gpu,"B",200,7).
component(gpu,"embedded graphic chipset",0,4).
% CPU C embeds a graphic card, that *may* be used.
require(gpu,"embedded graphic chipset",cpu,"C").

component(cpu,"A",400,10).
component(cpu,"B",150,6).
component(cpu,"C",250,6).
% CPU C embeds a graphic card.
require(cpu,"C",gpu,"embedded graphic chipset").

component(ram,"4Go",70,4).
component(ram,"8Go",130,7).
component(ram,"16Go",220,9).

component(hdd,"500Go",40,5).
component(hdd,"1To",50,7).
component(hdd,"2To",80,9).

component(ssd,"50Go",100,5).
component(ssd,"100Go",180,7).

component(motherboard,"full",140,8).
component(motherboard,"basic",70,5).
incompatible(motherboard,"basic",gpu,"embedded graphic chipset").
incompatible(motherboard,"basic",ram,"16Go").

component(cpufan,"big",100,8).
component(cpufan,"small",40,5).
require_one(cpufan,"small",cpu,("B";"C")).  % the small fan isn't enough for the CPU A

component(case,"big&quiet",150,7).
component(case,"big",120,5).
component(case,"small&quiet",100,7).
component(case,"small",70,5).
% the two small cases are not compatible with many components.
incompatible(case,("small";"small&quiet"),gpu,"A").
incompatible(case,("small";"small&quiet"),motherboard,"full").
incompatible(case,("small";"small&quiet"),cpufan,"big").



%%%%%%%%%%%%%%%%
% PREFERENCES
%%%%%%%%%%%%%%%%
% SSD is not necessary.
optional(ssd).

% Set importances of various components (default is 5).
set_importance(gpu,10).  % better have a good GPU
set_importance(motherboard,3).
set_importance(ssd,4).




%%%%%%%%%%%%%%%%
% KNOWLEDGE
%%%%%%%%%%%%%%%%
% CPU and motherboard must have the same bridge.
incompatible(cpu,CPU,motherboard,MB):- component(cpu,CPU) ; component(motherboard,MB) ;
                                       bridge(cpu,CPU,CPU_Bridge) ; bridge(motherboard,MB,MB_Bridge) ;
                                       MB_Bridge != CPU_Bridge.




%%%%%%%%%%%%%%%%
% EXPANSION
%%%%%%%%%%%%%%%%
% Extract components data.
component(O,Name):- component(O,Name,_,_).
price(O,Name,P):- component(O,Name,P,_).
rate(O,Name,R):- component(O,Name,_,R).

% By default, a component is necessary.
minimal_quantity(O,1):- component(O) ; not optional(O).
minimal_quantity(O,0):- component(O) ; optional(O).

% By default, all components are equivalent in importance.
importance(O,5):- component(O) ; not set_importance(O,_).
importance(O,I):- component(O) ; set_importance(O,I).

% Embedding is synonymous to symmetric requirement.
require(C1,N1,C2,N2):- embeds(C1,N1,C2,N2).
require(C2,N2,C1,N1):- embeds(C1,N1,C2,N2).




%%%%%%%%%%%%%%%%
% MODEL
%%%%%%%%%%%%%%%%
component(O):- component(O,_).

% Choose one of each components.
Q { use(O,X): component(O,X) } 1 :- component(O) ; minimal_quantity(O,Q).

% Requirements of a component must be in the config.
use(O2,N2):- use(O1,N1) ; require(O1,N1,O2,N2).
1 { use(O2,X): require_one(O1,N1,O2,X) } 1:- use(O1,N1) ; require_one(O1,N1,O2,_).

% Avoid any incompatibilities.
:- incompatible(O1,N1,O2,N2) ; use(O1,N1) ; use(O2,N2).

% Compute the total cost, rating and elements of the configuration.
total_cost(T):- T=#sum{C,O: use(O,I), price(O,I,C)}.
total_rate(T):- T=#sum{R*I,O: use(O,C), rate(O,C,R), importance(O,I)}.
total_size(T):- T={use(_,_)}.

% The total cost must be inferior to the maximal.
:- total_cost(T) ; T>max_cost.

% Maximize the overrall rating.
#maximize{S:total_rate(S)}.


#show.
#show use/2.
#show total_cost/1.
#show total_rate/1.
#show total_size/1.
