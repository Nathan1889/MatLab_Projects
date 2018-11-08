%Name: Nathan Egan
%Date: 31 Oct 2017
%contact: ne573414@ohio.edu
%Course: EE3713 F17 Matlab Project 01

%This function will approximate pi by dropping random points on a plane
% to approximate the area of a circle inside a square.
%For the purposes of this function, a circle with radius 1 and square with
% width 2, both origin centered, will be used.
function [myMean, myVar, mySD, N,M,B] = PiApprox (N, M, B)
    if (~exist('N','var') || N < 0 || ~isnumeric(N) || N ~= round(N) || ~isfinite(N))
        N = 1000;
    end
    %ensure N has a proper value
    
    if (~exist('M','var') || M < 0 || ~isnumeric(M) || M ~= round(M) || ~isfinite(M))
        M = 1000;
    end
    %ensure M has a proper value
    
    if (~exist('B','var'))
        B = 0;
    elseif (B < 0 || ~isnumeric(B) || B ~= round(B) || ~isfinite(B))
        B = 10;
    end
    %ensure B has a proper value
    
    A = rand(2*M,N);                      
    %Make cartesian coordinates where the top half of A is x values, bottom
    %half is y values.
    %Every pair of values ( A(r,c),(A(M/2 + r,c) makes a point on a
    %cartesian plane
    
    
    
    over_half = M + 1;
    dist = A(1:M,:).^2 + (A(over_half:end, : ) ).^2;
    %Store the distance of each point from circle center (0,0)
    
    
    A = dist < 1; 
    %set A to be booleans. 1 implies in the circle, 0 implies not in circle
    
    count_in_circle = sum(transpose(A));
    %sume each row of A to find how many points are in the circle
    
    circle_area_approx = (count_in_circle./N).*4;
    %determine the percentage of points that lie within the circle and
    %multiply by the area of the square to approximate the circle area
    
    %All code above this can be compressed down to one line, although its 
    % difficult to read
    %  circle_area_approx = (sum((transpose(rand(2*M,N).^2 + (rand(2*M,N)).^2) < 1))./N).*4;
    
    myMean = mean(circle_area_approx);
    myVar = var(circle_area_approx);
    mySD = std(circle_area_approx);
    %set outputs with MatLab functions
    
    if (B ~= 0)
       histogram(circle_area_approx, B);
    end
    %plot a histogram of all the approximations
end        