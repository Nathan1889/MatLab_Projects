%Author: Nathan Egan
%Assignment: EE3713 final project part 1: craps simulation
%Although not neccessary by the instructions of this project, I will be
%avoiding the use of explicit loops as much as possible, just for the
%interesting puzzles it can present
function [estimated_winrate,estimated_winnings, N,M] = Craps_Monte_Carlo(N, M)
    if (~exist('N','var') || N < 0 || ~isnumeric(N) || N ~= round(N) || ~isfinite(N))
        N = 1000;
    end
    %ensure N has a proper value
    
    if (~exist('M','var') || M < 0 || ~isnumeric(M) || M ~= round(M) || ~isfinite(M))
        M = 1000;
    end
    %ensure M has a proper value

    %Make an aray of MxN rolls each with a value of 2d6
    initial = randi(6, M, N) + randi(6, M, N);
    
    %find all of the rolls that immediately pay out
    immediate_wins = ( (initial == 7) | (initial == 11));
    total_wins = sum(immediate_wins,2);
    
    %find all of the rolls that immediately crap out
    immediate_losses = ( (initial == 2) | (initial == 3) | (initial == 12));
    
    %Store which elements have already been decidedly won or lost
    initial_results = (immediate_wins | immediate_losses);
    
    %set the values that already paid out to sentinel value -1
    initial(initial_results == 1) = -1;

    %I tried very hard to get rid of this loop, but I can't think of any
    %way to vectorize it, otherwise had I not had it in pace already
    %the earlier code would be inside the loop as well
    
    %iterte over every element in initial
    for i = 1:M
    for j = 1:N
        if initial(i,j) == -1 %if we already determined whether or not it paid out
           continue   %skip to the next element
        end
    
        keep_rolling = true; %loop control
        while keep_rolling
           tmp = (randi(6) + randi(6)); %make a roll
           if tmp == initial(i,j) %if you rolled the point value
               total_wins(i,1) = total_wins(i,1) + 1;
               keep_rolling = false;
           elseif tmp == 7 %if you just lost
                keep_rolling = false;
           end
        end
    end
    end

    %compute the average rond won/average winnings of N rounds of craps for
    %all M trials
    avg_winrate = total_wins * 1/N;
    avg_winnings = total_wins - (N - total_wins);
    avg_winnings = avg_winnings * 1/N;
    
    %average out the results over M trials
    estimated_winrate = sum(avg_winrate) * 1/M;
    estimated_winnings = sum(avg_winnings) * 1/M;