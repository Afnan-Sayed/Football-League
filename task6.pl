%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TASK6 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% find the top goal scorer in the tournament
top_scorer(Player):-        %% the interface the user queries through
    top_scorer_acc(Player,_ , 0).

% RecursiveCase
top_scorer_acc(Player ,_, MaxGoals):-
    goals(CurPlayer,CurGoals),  
    CurGoals >MaxGoals,             
    !,                                 
    top_scorer_acc(Player, CurPlayer, CurGoals). %update the max goals and continue searching

% BaseCase
top_scorer_acc(MaxPlayer, MaxPlayer, _).
