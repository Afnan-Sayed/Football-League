%%%%%%%%%%%% MY_APPEND %%%%%%%%%%%%
%BaseCase
my_append([], L, L).

%RecursiveCase
my_append([H|T],L2,[H|NT]):-
    my_append(T, L2,NT) .

%%%%%%%%%%%% MY_MEMBER %%%%%%%%%%%%
%BaseCase
my_member(X,[X|_]):- !.

%RecursiveCase
my_member(X  , [_ |Tail]):-
    my_member(X,Tail).

%%%%%%%%%%%% NOT_MY_MEMBER %%%%%%%%%%%%
%BaseCase
not_my_member(_ , []):- !.

%RecursiveCase
not_my_member(X, [H|T]):- 
    X \= H, 
    not_my_member(X, T).

%%%%%%%%%%%% LIST_LENGTH %%%%%%%%%%%%
list_length( L,N):-
    list_length_acc(L,0,N).

%BaseCase
list_length_acc([],N , N).

%RecursiveCase
list_length_acc([_| T], N,Res):-
    NewN is N+1,
    list_length_acc(T,NewN,Res).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TASK1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
players_in_team(Team, L):-              %% the interface the user queries through
    players_in_team_acc(Team,[], L).   %% the actual predicate we used to solve the task, this empty list is the accumlator

%RecursiveCase: 
players_in_team_acc(Team, TmpL, ResLst):-
    player(P, Team, _),  

    %% to make the predicate only appends the player who is not in the list yet 
    %% to avoid infinite recursion
    not_my_member(P, TmpL),     

    my_append([P], TmpL, TmpLst), !, 
    players_in_team_acc(Team, TmpLst, ResLst).

%BaseCase: once no more players found for the team, return the accumelated list
players_in_team_acc(_, L, L).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TASK2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% count how many teams are from a specific country
team_count_by_country(Country,N):-          %the interface the user queries through
    teams_count_by_country_acc(Country, Teams, []),  %the choosen country
    list_length(Teams,N).            % NO. of teams with same con

%RecursiveCase
teams_count_by_country_acc(Country,Teams, Accu):-
    team(Name,Country,  _),          
    not_my_member(Name,Accu),                %no du
    !,
    teams_count_by_country_acc(Country,Teams, [Name |Accu]).

%BaseCase when no more matches
teams_count_by_country_acc(_, Teams, Teams).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TASK3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
    NewBest = CurT.          %update with the cur team, the team related to this Num

update_best_team(Num, Max,_ ,CurT, NewBest):-
    Num\= Max, 
    NewBest =CurT.    %update with the team related to the new max num

%check if all teams are visited 
all_teams_visited([]).

all_teams_visited([H|T]):-
    team(H,_, _),
    all_teams_visited(T).
    
most_successful_team(T):-       %the interface which the user queries through

    %% 0 is the initial number in the comparison to get the max Num_of_winning_times
    %% '' is the current team wich will be compared with the final result returned in T
    most_successful_team_acc(T,'',0,[]), !.

%RecursiveCase
most_successful_team_acc(T,CurT,CurMax,VisitList):-
    team(Team, _, Num),
    not_my_member(Team, VisitList), %% make sure it is not visited

    %% compare between the current max winning times and the num for the new team test
    which_is_max(CurMax,Num,Max), 

    update_best_team(Num, Max, Team, CurT, NewBest),
        
    my_append([Team], VisitList, AppendResLst),  %% mark as visited
   
    most_successful_team_acc(T,NewBest,Max,AppendResLst).


%BaseCase: when no more teams left to process, return the best team found
most_successful_team_acc(T, CurT, _, VisitList):-
    all_teams_visited(VisitList),
    T = CurT.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TASK4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%check if team is participant as team1
match_participant(Team, Team, T2, G1, G2):- 
    match(Team, T2, G1, G2).

%check if team is participant as team2
match_participant(Team, T1, Team, G1, G2):-
    match(T1, Team, G1, G2).


%% list all matches where a specific team participated 
matches_of_team(Team, Matches):-       % the interface the user queries through
    collect_matches(Team,Matches,[]).  % collect matches with empty accumulator list

%RecursiveCase
 collect_matches(Team, Matches, MatchGather):-

    %find a match from the facts: match(Team1, Team2, Team1Goals, Team2Goals)
    match(T1, T2, G1, G2),              

    % check if the team participated in the match either as team1 or team2
    match_participant(Team, T1, T2, G1, G2),   

    %create a list representing the match
    NewMatch = (T1, T2, G1, G2),          %store the match as a list [Team1, Team2, Goals1, Goals2]

    %ensure the match is not already in the accumulator to avoid duplicates
    not_my_member(NewMatch,MatchGather),         %true if NewMatch not in acc
    !,                                   

    collect_matches(Team, Matches,[NewMatch | MatchGather]). %add NewMatch to accum. and cont search

%BaseCase 
 collect_matches(_, Matches, Matches).     %no more matches exist return the accumu as the result

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TASK5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% count all matches where a specific team participated 
num_matches_of_team(Team, N):-
    matches_of_team(Team, Matches),      
    list_length(Matches,N).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TASK6 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% find the top goal scorer in the tournament
top_scorer(Player):-        %% the interface the user queries through
    top_scorer_acc(Player,_ , 0).

%RecursiveCase
top_scorer_acc(Player,_, MaxGoals):-  %second arguement is for the max player
    goals(CurPlayer,CurGoals),  
    CurGoals >MaxGoals,             
    !,                                 
    top_scorer_acc(Player, CurPlayer, CurGoals). %update max goals and cont searching

%BaseCase
top_scorer_acc(MaxPlayer,MaxPlayer, _).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TASK7 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
