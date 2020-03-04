% Input: number of iterations L
% matrix X of features, with n rows (samples), d columns (features)
% X(i,j) is the j-th feature of the i-th sample
% vector y of labels, with n rows (samples), 1 column
% y(i) is the label (+1 or -1) of the i-th sample
% Output: vector alpha of weights, with L rows, 1 column
% vector theta of feature indices, with L rows, 1 column

function [alpha theta] = adaboost(L,X,y)
alpha = zeros(L, 1);
theta = ones(L,1);
n = size(X,1);
d = size(X,2);
W = zeros(n,1);
for t = 1:n
    W(t) = 1/n;
end
for r = 1:L
    minsum = - diag(W*y')' * sign(X);
    [val, ix] = min(minsum);
    theta(r) = ix;
    eps = val;
    if eps >= 0
        return
    end
    eps = max([eps, -0.99]);
    alpha(r) = 1/2 * log((1-eps)/(1+eps));
    for t = 1:n
        raise = -alpha(r)*y(t)*sign(X(t,ix));
        W(t) = W(t)*exp(raise);
    end
    z = sum(W);
    W = W/z;
end
end