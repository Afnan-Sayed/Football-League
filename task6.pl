%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TASK6 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% predicate to find the top goal scorer
top_scorer(Player) :-
    get_top_scorer(Player, _, 0).

% Helper predicate to find the top goal scorer
get_top_scorer(Player, MaxPlayer, MaxGoals) :-
    goals(CurrentPlayer, CurrentGoals),  % Find a player and their goals
    CurrentGoals > MaxGoals,             % Check if this player has more goals than the current maximum
    !,                                   % Commit to this player (cut to prevent backtracking)
    get_top_scorer(Player, CurrentPlayer, CurrentGoals). % Update the maximum and continue searching

% Base case
get_top_scorer(MaxPlayer, MaxPlayer, _). 