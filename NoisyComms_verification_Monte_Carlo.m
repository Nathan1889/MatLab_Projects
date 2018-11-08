%Author: Nathan Egan
%Assignment: EE3713 final project part 2.2: verify that a normal
%distribution with mean of 0 and SD of 4.974 will reduce bit errors to 1 in
%a billion
%Although not neccessary by the instructions of this project, I will be
%avoiding the use of explicit loops as much as possible, just for the
%interesting puzzles it can present
function [errors] = NoisyComms_verification_Monte_Carlo ()

    %note: I could vectorize this by cutting it into repeating the same
    %code four+ times with smaller arrays, but I realize when I'm being
    %pedantic. In this case loops are actually better than vectorization
    errors = 0;
    N = 100000000; %N+N_2 is effectively the size of a signle message
    N_2 = 10; 
    M = 5; %number of messages sent
    for i = 1:M 
    for j = 1:N_2
    %for j = 1:(N*N_2)%trying to vectorize this would take 75GB...
        send_bit = randi(2,1,N); %generate random string of 1's and 2's 
        msg_bit = (send_bit == 1); %shows the message itself as 1's and 0's
        send_bit(send_bit == 2) = -1; %convert the sent to voltages +/-1
        send_bit = send_bit + normrnd(0,1/6, 1, N); %add noise to the signal
        recieved = (send_bit >= 0); %decode the signal
        errors = errors + sum(recieved ~= msg_bit); %count every place they do not match
       
    end
    end
    errors = errors * 1/M * 1/N * 1/N_2; %calculate chance of a single error
    disp(errors); 
    