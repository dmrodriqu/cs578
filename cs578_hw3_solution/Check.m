% dylan rodriquez
% checks for number of errors with adaboost
% and adapred

[X y] = createsepdata(1000, 100);
[alpha theta] = adaboost(100, X, y);
errors = 0;
for l = 1:size(y,1)
    x = X(l,:);
    label = adapred(alpha, theta, x);
    if label ~= y(l)
        errors = errors + 1;
    end
end
e = errors