% Input: vector theta of d rows, 1 column
% vector x of d rows, 1 column
% Output: label (+1 or -1)
function label = linpred(theta,x)
    if x' * theta > 0
        label = 1;
    else
        label = -1;
end