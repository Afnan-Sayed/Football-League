%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TASK2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Main predicate to counts teams from specific country
team_count_by_country(Country, Count) :-
    get_teams_by_country(Country, Teams, []),  %the choosen country
    list_count(Teams, Count).                      % NO of teams with same con


get_teams_by_country(Country,  TeamsList,  Accu) :-
    team(Name, Country,  _),              % search database
    \+ member(Name, Accu),                % no du
    !,
    get_teams_by_country(Country, TeamsList, [Name|Accu]).  % rec call

% Base case: return the acc if no more match
get_teams_by_country(_, TeamsList, TeamsList).

%to count number teams in list
list_count([], 0).
list_count([_|T], Count) :-
    list_count(T, TCount),
    Count is  TCount  +  1.

% Member to prevent dup
member(X, [X|_]).
member(X, [_|T]) :-
    member(X, T).