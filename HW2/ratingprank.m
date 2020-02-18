% Input: number of iterations L
%        number of labels k
%        matrix X of features, with n rows (samples), d columns (features)
%           X(i,j) is the j-th feature of the i-th sample
%        vector y of labels, with n rows (samples), 1 column
%           y(i) is the label (1 or 2 ... or k) of the i-th sample
% Output: vector theta of d rows, 1 column
%         vector b of k-1 rows, 1 column
function [theta b] = ratingprank(L,k,X,y)
    theta = zeros(size(X,2),1);
    b     = zeros(k-1,1);    
    for l = 1:k-1
        b(l) = l;
    end
    s     = ones(size(X,1),k-1);
    for t = 1:size(X,1)
        for l = 1:k-1
            if y(t) <= l
                s(t,l) = -1;
            end
        end
    end
    
    for iter = 1:L
        E = [];
        for l = 1:k-1
            if s(t,l)*(X(t,:)*theta - b(l)) <= 0
                E = [E;l];
            end
        end
        for t = 1:size(X,1)
            if ~isempty(E)
                sum_E = 0;
                for i = 1:length(E)
                    sum_E = sum_E + s(t,E(i));
                    b(E(i)) = b(E(i)) - s(t,E(i));
                end
            end
        end
    end
end