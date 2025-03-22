%%%%%%%%%%%% NOT_MY_MEMBER %%%%%%%%%%%%
% Base Case
not_my_member(_, []):-
    !.

% Recursive Case
not_my_member(X, [H|T]):- 
    X \= H, 
    not_my_member(X, T).
    

%check if team is participant as team1
match_participant(Team, Team, T2, G1, G2):- 
    match(Team, T2, G1, G2).

%check if team is participant as team2
match_participant(Team, T1, Team, G1, G2):-
    match(T1, Team, G1, G2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TASK4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  List all matches where a specific team participated 

matches_of_team(Team, Matches):-       % the interface the user queries through
    collect_matches(Team,Matches,[]).  % collect matches with empty accumulator list

% RecursiveCase
 collect_matches(Team, Matches, MatchesGathered):-

    %find a match from the facts: match(Team1, Team2, Team1Goals, Team2Goals)
    match(T1, T2, G1, G2),              

    % check if the team participated in the match either as team1 or team2
    match_participant(Team, T1, T2, G1, G2),   

    %create a list representing the match
    NewMatch = [T1, T2, G1, G2],          %store the match as a list [Team1, Team2, Goals1, Goals2]

    %ensure the match is not already in the accumulator to avoid duplicates
    not_my_member(NewMatch,MatchesGathered),         %true if NewMatch is not in Acc
    !,                                   

    collect_matches(Team, Matches, [NewMatch | MatchesGathered]). %Add NewMatch to the accumulator and continue searching

% BaseCase 
 collect_matches(_, Matches, Matches).     % When no more matches exist, return the accumulator as the result

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TASK5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%% LIST_LENGTH %%%%%%%%%%%%
list_length(L,N):-
    list_length_acc(L, 0 ,N).

%% BaseCase
list_length_acc([], N ,N).

%% RecursiveCase
list_length_acc([_|T], N,Res):-
    NewN is N+1,
    list_length_acc(T,NewN,Res).

%% count all matches where a specific team participated 
num_matches_of_team(Team, N):-
    matches_of_team(Team, Matches),      
    list_length(Matches,N).
