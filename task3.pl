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


%%%%%%%%%%%% which_is_max %%%%%%%%%%%%
which_is_max(X,Y,Max):-
    X>=Y,
    Max is X.

which_is_max(X,Y,Max):-
    Y>X,
    Max is Y.

%%%%%%%%%%%% update_best_team %%%%%%%%%%%%
update_best_team(Num, Max, CurT, _, NewBest):-
    Num = Max, 
    NewBest = CurT.          % update with the cur team, the team related to this Num

update_best_team(Num, Max,_ ,CurT, NewBest):-
    Num \= Max, 
    NewBest = CurT.    % update with the team related to the new max num
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TASK3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% check if all teams are visited 
all_teams_visited([]).

all_teams_visited([H|T]):-
    team(H, _, _),
    all_teams_visited(T).
    

most_successful_team(T):-       %% the interface which the user queries through

    %% 0 is the initial number in the comparison to get the max Num_of_winning_times
    %% '' is the current team wich will be compared with the final result returned in T
    most_successful_team_acc(T,'',0,[]), !.


%% Recursive Case
most_successful_team_acc(T,CurT,CurMax,VisitList):-
    team(Team, _, Num),
    not_my_member(Team, VisitList), %% make sure it is not visited

    %% compare between the current max winning times and the num for the new team test
    which_is_max(CurMax,Num,Max), 

    update_best_team(Num, Max, Team, CurT, NewBest),
        
    my_append([Team], VisitList, AppendResLst),  %% mark as visited
   
    most_successful_team_acc(T,NewBest,Max,AppendResLst).


%% Base Case: when no more teams left to process, return the best team found
most_successful_team_acc(T, CurT, _, VisitList):-
    all_teams_visited(VisitList),
    T = CurT.