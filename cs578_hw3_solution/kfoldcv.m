% Input: number of folds k
% matrix X of features, with n rows (samples), d columns (features)
% vector y of scalar values, with n rows (samples), 1 column
% Output: vector z of k rows, 1 column
function z = kfoldcv(k,X,y)
n = size(y,1);
folds = [];
seq = 1:n;
z = zeros(k,1);
for i = 1:k
    start = floor((n*(i-1))/k) + 1;
    stop = floor((n*(i/k)));
    folds = setdiff(seq, start:stop);
    callx = X(folds,:);
    thetahat = linreg(callx, y(folds));
    zi = 0;
    tmag = 1/(folds*folds');
    total = 0;
    for tx = 1:length(folds)
        tnum = folds(tx);
        dp = dot(thetahat, X(tnum,:));
        true = (y(tnum,:));
        mse = true - dp;
        mse = mse.^2;
        total= total +mse;
    end
    totalmag = tmag*total;
    z(i) = totalmag;
end
