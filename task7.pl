%%%%%%%%%%%% NOT_MY_MEMBER %%%%%%%%%%%%
% Base Case
not_my_member(_, []):-
    !.

% Recursive Case
not_my_member(X, [H|T]):- 
    X \= H, 
    not_my_member(X, T).

%%%%%%%%%%%% MY_MEMBER %%%%%%%%%%%%
% BaseCase
my_member(X, [X|_]):-
    !.

% RecursiveCase
my_member(X, [_|Tail]):-
    my_member(X, Tail).


most_common_position_in_team(Team, Pos):-
    get_all_positions(Team, Positions),           %get all positions of players in the team

    remove_duplicates(Positions, UniquePositions),        %create a list of unique positions

    count_each_position(Positions, UniquePositions, Counts),    %count how many players are in each position
    
    find_highest_count_position(UniquePositions,Counts,Pos),    %position with the highest count
     !.

get_all_positions(Team, Positions):-   %the interface the user queries through
    get_all_positions(Team, [], Positions).

%RecursiveCase
get_all_positions(Team, Acc, Positions):-
    player(_, Team, Pos),  
    not_my_member(Pos, Acc), 
    get_all_positions(Team, [Pos|Acc], Positions).

%BaseCase
get_all_positions(_, Positions, Positions).  


%BaseCase
remove_duplicates([], []).  

remove_duplicates([Pos|Rest], UniquePositions):-
    my_member(Pos, Rest),  
    remove_duplicates(Rest, UniquePositions).

remove_duplicates([Pos|Rest], [Pos|UniquePositions]):-
   not_my_member(Pos,Rest), 
    remove_duplicates(Rest, UniquePositions).

%BaseCase no positions left
count_each_position(_, [], []).

count_each_position(Positions, [Pos|UniquePositions], [Count|Counts]):-
    count_occurrences(Positions, Pos, Count),  %count how many times position appears
    count_each_position(Positions, UniquePositions, Counts).

%BaseCase
count_occurrences([], _, 0).  
count_occurrences([Pos|Rest], Pos, Count):-
    count_occurrences(Rest, Pos, TempCount),  
    Count is TempCount+1.

count_occurrences([OtherPos|Rest], Pos, Count):-
    OtherPos \= Pos,  %skip if the position does not match
    count_occurrences(Rest , Pos,Count).


% BaseCase only one position left
find_highest_count_position([Pos], _, Pos).

% Case 1: Count1 > Count2
find_highest_count_position([Pos1,_|Rest], [Count1, Count2|Counts],CommonPos):-
    Count1 > Count2,  
    find_highest_count_position([Pos1|Rest], [Count1|Counts],CommonPos).

% Case 2: Count1 =< Count2
find_highest_count_position([_, Pos2|Rest], [Count1, Count2|Counts], CommonPos):-
    Count1 =< Count2, 
    find_highest_count_position([Pos2|Rest],[Count2|Counts] ,  CommonPos).
