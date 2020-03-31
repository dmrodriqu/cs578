% CS578, Spring 2020, Instructor: Jean Honorio (jhonorio@purdue.edu)

% Input: number of iterations L
%        matrix X of features, with n rows (samples), d columns (features)
%            X(i,j) is the j-th feature of the i-th sample
%        vector y of labels, with n rows (samples), 1 column
%            y(i) is the label (+1 or -1) of the i-th sample 
% Output: vector alpha of weights, with L rows, 1 column
%         vector theta of feature indices, with L rows, 1 column
function [alpha theta] = adaboost(L,X,y)

[n d] = size(X);
alpha = zeros(L,1);
theta = ones(L,1);
W = ones(1, n) ./ n;
V = y .* sgn(X);
for r = 1:L
    % compute theta and epsilon
    [ep i] = min(- W * V);
    theta(r) = i;

    if ep >= 0
        return
    end
    
    % Update epsilon
    ep = max(ep, -0.99);
    % Update alpha
    alpha(r) = 0.5 * log((1 - ep)/(1 + ep));
    % Update weights
    W = W .* exp(- alpha(r) .* (V(:, theta(r))'));
    % Normalize weights
    W = W ./ sum(W);
end
end % end of function.

function S = sgn(X)
S = sign(X);
S(S == 0) = -1;
end % end of function.
