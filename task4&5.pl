%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TASK4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Predicate to find all matches of a specific team
matches_of_team(Team, Matches) :-
   % Start collecting matches with an empty list as the accumulator.   
    collect_matches(Team, Matches, []).


% Helper predicate to recursively collect matches involving a specific team
 collect_matches(Team, Matches, MatchesGathered) :-

    % Find a match from the facts: match(Team1, Team2, Goals1, Goals2).
    match(T1, T2, G1, G2),              

    % Check if the team participated in the match (either as Team1 or Team2).
    (T1 = Team ; T2 = Team),              % true if Team is T1 or T2

    % Create a tuple representing the match.
    NewMatch = (T1, T2, G1, G2),          % Store the match as a tuple (Team1, Team2, Goals1, Goals2).

    % Ensure the match is not already in the accumulator to avoid duplicates.
    \+ member(NewMatch,MatchesGathered),             % true if NewMatch is not in Acc

    % Use a cut (!) to commit to this match and prevent backtracking.
    !,                                    % Prevents Prolog from searching for alternative matches for the same team.

    % Recursively call collect_matches/3, adding the new match to the accumulator.
    collect_matches(Team, Matches, [NewMatch | MatchesGathered]). % Add NewMatch to the accumulator and continue searching.

% Base case 
 collect_matches(_, Matches, Matches).     % When no more matches exist, return the accumulator as the result.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TASK5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicate to count how many matches a team participated in
num_matches_of_team(Team, Count) :-
    matches_of_team(Team, Matches),       % Reuse Task 4 predicate
    list_count(Matches, Count).           % Count elements in the list
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TASK6 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

