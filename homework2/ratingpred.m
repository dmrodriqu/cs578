
% Input: number of labels k
%        vector theta of d rows, 1 column3
%        vector b of k-1 rows, 1 column
%        vector x of d rows, 1 column
% Output: label (1 or 2 ... or k)
function label = ratingpred(k,theta, b, x)
    label = 0; % dummy starting value
    for i = 1:k-1
        if theta'*x - b(i) <= 0
            label = i;
            break
        end
    end
    if label == 0
        label = k;
    end
end