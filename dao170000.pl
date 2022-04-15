%PROGRAM 1
checkodd(Q):-
    R is Q mod 2,
    R is 1 -> true
    ;false.

checkmultiple(N):-
    R is N mod 3,
    R is 0 -> Q is N/3, checkodd(Q)
    ;false.

oddMultOf3(N):-
    not(integer(N)) ->
    writeln("ERROR: The given parameter is not an integer")
    ;checkmultiple(N).

%PROGRAM 2
list_prod(list, integer).
list_prod([], 0).
list_prod([H], H).
list_prod([H|T], Product):-
    list_prod(T, Rest),
    Product is Rest * H.

%PROGRAM 3
palindrome(L):-
    palindrome(L,L).

palindrome(L,R):-
    myrev(L,R,[]).

myrev([],R,R).
myrev([X|L],R,Acc):-
    myrev(L,R,[X|Acc]).

%PROGRAM 4
len([],0).
len([_|T],R):-
    len(T,R1),
    R is R1+1.

checklist([]):-true.
checklist([H|T]):-
    not(number(H))-> write("ERROR: \""),print(H),writeln("\" is not a number."),false
    ;checklist(T).

findmin([],[]).
findmin([_,H2|_],M2):-
    M2 is H2.

secondMin(List,M2):-
    sort(List,List2),
    len(List2,L),
    L < 2 -> writeln("ERROR: List has fewer than two unique elements.")
    ;checklist(List)->
    sort(List,List2),
    findmin(List2,M2),!;!.

%PROGRAM 5
classify([], [], []).
classify(List, Even, Odd):-
    [X|Xs]=List,
    0 is X mod 2,(Even=[X|Even1],
    classify(Xs, Even1, Odd)).

classify(List, Even, Odd):-
    [X|Xs]=List,
    1 is X mod 2,(Odd=[X|Odd1],
    classify(Xs, Even, Odd1)).

%PROGRAM 6
prefix([],_).
prefix([A|B],[A|C]):-
    prefix(B,C).

suffix(A,B):-
    reverse(A,AR),
    reverse(B,BR),
    prefix(AR,BR).

bookends(F,S,T):-
    prefix(F,T),
    suffix(S,T).

%PROGRAM 7
subslice([],_):- !.
subslice(SubPart,[A|B]):-
    prefix(SubPart,[A|B]),!;
    subslice(SubPart,B).

%PROGRAM 8
rev([],L2,L2).
rev([H|T],L2,R):-
    rev(T,[H|L2],R).

rev(L,R):-
    rev(L,[],R).

conc([],L2,L2).
conc([H1|T1],L2,[H1|T3]):-
    conc(T1,L2,T3).

sublist(L,0,L).
sublist([_|T],N,X):-
    N2 is N-1,
    sublist(T,N2,X),!.

shiftleft(List,N,Shifted):-
    len(List,L),
    rev(List,First),
    sublist(First,L-N,First_rev),
    sublist(List,N,Second),
    rev(Second,Second_rev),
    conc(First_rev,Second_rev,R1),
    rev(R1,Shifted).

shiftright(List,N,Shifted):-
    len(List,L),
    rev(List,First),
    sublist(First,N,First_rev),
    sublist(List,L-N,Second),
    rev(Second,Second_rev),
    conc(First_rev,Second_rev,R1),
    rev(R1,Shifted).

shift(List,N,Shifted):-
    N < 0-> N1 is (-1*N),shiftright(List,N1,Shifted)
    ;shiftleft(List,N,Shifted).

%PROGRAM 9
sum2(Num,Result):-
    N1 is mod(Num,10),
    N2 is div(Num,10),
    Result is N1+N2,!.

sum(Num,Result):-
    N1 is mod(Num,10),
    N2 is div(Num,10),
    N3 is N2*2,
    N3>9 -> sum2(N3,X),Result is X+N1,!;
    N1 is mod(Num,10),
    N2 is div(Num,10),
    N3 is N2*2,
    Result is N1+N3,!.

digitsum(0,Sum,Result):-
    Result is Sum,!.

digitsum(N,Sum,Result):-
    Rem is mod(N,100),
    Ques is div(N,100),
    sum(Rem,S2),
    NewSum is Sum+S2,
    digitsum(Ques,NewSum,Result),!.

luhn(Num):-
    digitsum(Num,0,Result),
    Rem is mod(Result,10),
    Rem = 0.

%PROGRAM 10
edge(a,b).
edge(b,c).
edge(c,d).
edge(d,a).
edge(d,e).
edge(b,a).

path(X,Y):-
    edge(X,Y),!.

path(X,Y):-
    edge(X,R),
    path(R,Y),!.

cycle(X):-
    path(X,X),!.
