% Input: number of features F
% data matrix X, with n rows (samples), d columns (features)
% Output: average mu, with d rows, 1 column
% principal component matrix Z, with d rows, F columns
function [mu Z] = pcalearn(F,X)
    n = size(X,1);
    d = size(X,2);
    mu = zeros(1,d);
    for i = 1:d
       mu(i) = mean(X(:,i));
    end
    for t=1:n
        X(t,:)= X(t,:) - mu;
    end
    [U, D, V] = svd(X, 'econ');
    E = D(1:F, 1:F);
    W = V(:,1:F);
    Z = sqrt(n)*W*inv(E);
    mu = mu.';
end