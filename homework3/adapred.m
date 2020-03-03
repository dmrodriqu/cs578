
% Input: vector alpha of weights, with L rows, 1 column
%vector theta of feature indices, with L rows, 1 column
% vector x of d rows, 1 column
% Output: label (+1 or -1)
function label = adapred(alpha,theta,x)
L = size(alpha, 1)
total = 0;
for r = 1:L
    total = total + alpha(r)*sign(x(theta(r)'));
end
label = sign(total)