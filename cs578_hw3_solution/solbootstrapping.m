% CS578, Spring 2020, Instructor: Jean Honorio (jhonorio@purdue.edu)

% Input: number of bootstraps B
%        matrix X of features, with n rows (samples), d columns (features)
%        vector y of scalar values, with n rows (samples), 1 column
% Output: vector z of B rows, 1 column
function z = bootstrapping(B,X,y)
    rng(1);
    [n, ~] = size(X);
    examples = 1:n;
    z = zeros(B, 1);
    for i = 1:B
        u = datasample(examples, n);
        S = unique(u);
        T = setdiff(examples, S);
        sizeT = size(T, 2);
        theta = linreg(X(u, :), y(u));
        error = y(T) - sum(repmat(theta', sizeT, 1).* X(T, :), 2);
        z(i) = sum(error.^2)/sizeT;
    end
    
