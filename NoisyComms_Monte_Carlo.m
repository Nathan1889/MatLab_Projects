%Author: Nathan Egan
%Assignment: EE3713 final project part 2: noisy comms simulation
%Although not neccessary by the instructions of this project, I will be
%avoiding the use of explicit loops as much as possible, just for the
%interesting puzzles it can present
function [avg_error_percentage_1,avg_error_percentage_2,avg_error_percentage_3, N,M] = NoisyComms_Monte_Carlo (N, M)
    if (~exist('N','var') || N < 0 || ~isnumeric(N) || N ~= round(N) || ~isfinite(N))
        N = 1000;
    end
    %ensure N has a proper value
    
    if (~exist('M','var') || M < 0 || ~isnumeric(M) || M ~= round(M) || ~isfinite(M))
        M = 1000;
    end
    %ensure M has a proper value
            
    %create a message consisting of -1 and 1
    message_sent = randi(2,M,N);

    message_sent(message_sent == 2) = -1;
    original_string = (message_sent == 1);
    
    %Add noise
    noisy1 = message_sent + normrnd(0,1,M,N);
    noisy2 = message_sent + normrnd(0,0.5,M,N);
    noisy3 = message_sent + normrnd(0,0.25,M,N);
    
    %determine what the message looks like after noise has been accounted
    %for
    message_recieved1 = (noisy1 >= 0);
    message_recieved2 = (noisy2 >= 0);
    message_recieved3 = (noisy3 >= 0);

    %find all the errors in each version of the message
    errorlist_1 = (message_recieved1 ~= original_string);
    errorlist_2 = (message_recieved2 ~= original_string);
    errorlist_3 = (message_recieved3 ~= original_string);
        
    %calculate the error percentage of each msg
    error_percentage_1 = sum(errorlist_1,2) * 1/N;
    error_percentage_2 = sum(errorlist_2,2) * 1/N;
    error_percentage_3 = sum(errorlist_3,2) * 1/N;
    
    %calculate the average error percentagebetween m trials
    avg_error_percentage_1 = sum(error_percentage_1) * 1/M;
    avg_error_percentage_2 = sum(error_percentage_2) * 1/M;
    avg_error_percentage_3 = sum(error_percentage_3) * 1/M;