% CS578, Spring 2020, Instructor: Jean Honorio (jhonorio@purdue.edu)

% Input: number of folds k
%        matrix X of features, with n rows (samples), d columns (features)
%        vector y of scalar values, with n rows (samples), 1 column
% Output: vector z of k rows, 1 column
function z = kfoldcv(k,X,y)
    [n, ~] = size(X);
    examples = 1:n;
    z = zeros(k, 1);
    for i=1:k
        T = floor(n*(i-1)/k)+1:floor(n*i/k);
        sizeT = size(T, 2);
        S = setdiff(examples, T);
        theta = linreg(X(S, :), y(S));
        error = y(T) - sum(repmat(theta', sizeT, 1).* X(T, :), 2);
        z(i) = sum(error.^2)/sizeT;
    end 
    
    
        
