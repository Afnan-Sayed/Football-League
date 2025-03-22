%%%%%%%%%%%% MY_APPEND %%%%%%%%%%%%
% Base Case
my_append([], L, L).

% Recursive Case
my_append([H|T], L2, [H|NT]):-
    my_append(T, L2, NT).

%%%%%%%%%%%% NOT_MY_MEMBER %%%%%%%%%%%%
% Base Case
not_my_member(_, []):-
    !.

% Recursive Case
not_my_member(X, [H|T]):- 
    X \= H, 
    not_my_member(X, T).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TASK1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
players_in_team(Team, L):-              %% the interface the user queries through
    players_in_team_acc(Team, [], L).   %% the actual predicate we used to solve the task, this empty list is the accumlator

%% Recursive Case: 
players_in_team_acc(Team, TmpL, ResLst):-
    player(P, Team, _),  

    %% to make the predicate only appends the player who is not in the list yet 
    %% to avoid infinite recursion
    not_my_member(P, TmpL),     

    my_append([P], TmpL, TmpLst),  
    !, 
    players_in_team_acc(Team, TmpLst, ResLst).

%% Base Case: once no more players found for the team, return the accumelated list
players_in_team_acc(_, L, L).