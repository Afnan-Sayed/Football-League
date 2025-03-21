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

    % Create a tuple representing the match.
    NewMatch = (T1, T2, G1, G2),          % Store the match as a tuple (Team1, Team2, Goals1, Goals2).

    % Ensure the match is not already in the accumulator to avoid duplicates.
    \+ member(NewMatch,MatchesGathered),             % true if NewMatch is not in Acc
    !,                                   

    collect_matches(Team, Matches, [NewMatch | MatchesGathered]). % Add NewMatch to the accumulator and continue searching

% Base case 
 collect_matches(_, Matches, Matches).     % When no more matches exist, return the accumulator as the result


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TASK5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicate to count how many matches a team participated in
num_matches_of_team(Team, Count) :-
    matches_of_team(Team, Matches),       % Reuse Task 4 predicate
    list_count(Matches, Count).           % Count elements in the list
