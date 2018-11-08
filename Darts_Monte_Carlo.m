%Author: Nathan Egan
%Assignment: EE3713 final project part 3: darts simulation
%Although not neccessary by the instructions of this project, I will be
%avoiding the use of explicit loops as much as possible, just for the
%interesting puzzles it can present
function [mean_dist, N, M] = Darts_Monte_Carlo(N,M)
    %NOTE: A lot of this code is adapted from the first Matlab assignment I did
    %to approximate pi. Since this problem is similar in structure, I decided
    %to recycle my own code

    if (~exist('N','var') || N < 0 || ~isnumeric(N) || N ~= round(N) || ~isfinite(N))
        N = 1000;
    end
    %ensure N has a proper value
    
    if (~exist('M','var') || M < 0 || ~isnumeric(M) || M ~= round(M) || ~isfinite(M))
        M = 1000;
    end
    %ensure M has a proper value

    A = normrnd(0,0.1,2*M,N);                      
    %Make cartesian coordinates where the top half of A is x values, bottom
    %half is y values.
    %Every pair of values ( A(r,c),(A(M/2 + r,c) makes a point on a
    %cartesian plane
    %changed from rand to normrnd
    
    over_half = M + 1;
    dist = A(1:M,:).^2 + (A(over_half:end, : ) ).^2;
    dist = sqrt(dist);
    mean_dist = mean(dist);
    %Store the distance of each point from dartboard center (0,0)
    
    t = linspace(0,2*pi); %to plot a circle
    %will only plot one set of N throws
    plot(A(1, : ), A(over_half, : ), 'b.', 1/2*0.45*cos(t), 1/2*0.45*sin(t), '--r', 'linewidth', 2.5);

%The following code deals with looking at the distance from the origin.
%This does not look anything like a Gaussian variable, my best guess is
%that it is an exponential variable with a lambda value of approximately
%47
%    [dist_bins, dist_centers] = hist(dist,100);
%    dist_bins = 1/(dist_centers(2) - dist_centers(1)) * 1/N * dist_bins;
%    tmp = exprnd(1/47, 1, N);
%    tmp = sort(tmp);
%    tmp_pdf = exppdf(tmp, 1/47);
%    plot(dist_centers, dist_bins, tmp, tmp_pdf);