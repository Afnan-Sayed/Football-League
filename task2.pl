%%%%%%%%%%%% NOT_MY_MEMBER %%%%%%%%%%%%
% Base Case
not_my_member(_, []):-
    !.

% Recursive Case
not_my_member(X, [H|T]):- 
    X \= H, 
    not_my_member(X, T).


%%%%%%%%%%%% LIST_LENGTH %%%%%%%%%%%%
list_length(L,N):-
    list_length_acc(L, 0 ,N).

%% BaseCase
list_length_acc([], N ,N).

%% RecursiveCase
list_length_acc([_|T], N,Res):-
    NewN is N+1,
    list_length_acc(T,NewN,Res).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TASK2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% count how many teams are from a specific country
team_count_by_country(Country,N):-          %the interface the user queries through
    teams_count_by_country_acc(Country, Teams, []),  %the choosen country
    list_length(Teams,N).            % NO. of teams with same con

%% RecursiveCase
teams_count_by_country_acc(Country,Teams, Accu):-
    team(Name,Country,  _),          
    not_my_member(Name, Accu),                % no du
    !,
    teams_count_by_country_acc(Country,Teams, [Name|Accu]).

%% BaseCase when no more matches
teams_count_by_country_acc(_, Teams, Teams).
