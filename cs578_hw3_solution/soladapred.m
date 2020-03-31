% CS578, Spring 2020, Instructor: Jean Honorio (jhonorio@purdue.edu)

% Input: vector alpha of weights, with L rows, 1 column
%        vector theta of feature indices, with L rows, 1 column
%        vector x of d rows, 1 column
% Output: label (+1 or -1)
function label = adapred(alpha,theta,x)

label = sgn(dot(alpha, sgn(x(theta))));
end % end of function

function S = sgn(X)
S = sign(X);
S(S == 0) = -1;
end % end of function.
