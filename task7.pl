%%%%%%%%%%%% NOT_MY_MEMBER %%%%%%%%%%%%
not_my_member(_, []) :- !.
not_my_member(X, [H|T]) :- 
    X \= H, 
    not_my_member(X, T).

%%%%%%%%%%%% MY_MEMBER %%%%%%%%%%%%
my_member(X, [X|_]) :- !.
my_member(X, [_|Tail]) :- 
    my_member(X, Tail).


most_common_position_in_team(Team, Pos):-
    get_all_positions(Team, Positions),
    remove_duplicates(Positions, UniquePos),
    count_each_position(Positions, UniquePos,Counts),
    find_highest_count_position(UniquePos,Counts, Pos), !.

%%%%%%%%%%%% GET ALL POSITIONS %%%%%%%%%%%%
get_all_positions(Team, Positions):-  %the interface the user queries through
    findall(Pos, player(_, Team, Pos), Positions).

%%%%%%%%%%%% REMOVE DUPLICATES %%%%%%%%%%%%

%BaseCase
remove_duplicates([], []).

remove_duplicates([H|T], Res):-
    my_member(H, T),
    remove_duplicates(T, Res).
remove_duplicates([H|T], [H|Res]):-
    not_my_member(H, T),
    remove_duplicates(T, Res).

%%%%%%%%%%%% COUNT EACH POSITION %%%%%%%%%%%%
%BaseCase no positions left

count_each_position(_, [], []).

count_each_position(All, [Pos|Rest], [Count|Counts]) :-
    count_occurrences(All, Pos, Count),
    count_each_position(All, Rest, Counts).

%BaseCase
count_occurrences([], _, 0).
count_occurrences([Pos|Rest], Pos, Count) :-
    count_occurrences(Rest, Pos, Temp),
     Count is Temp+1.
 
count_occurrences([Other|Rest], Pos, Count) :-
    Other \=Pos, %skipp if no match
    count_occurrences(Rest, Pos, Count).

%%%%%%%%%%%% FIND HIGHEST COUNT %%%%%%%%%%%%

find_highest_count_position([P],[_], P).

find_highest_count_position([P1,P2|PRest], [C1,C2|CRest], Res):-
    (
    C1>=C2 -> find_highest_count_position([P1|PRest],[C1|CRest],Res)
    ;   find_highest_count_position([P2|PRest],[C2|CRest],Res)
    ).
