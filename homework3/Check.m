[X y] = createsepdata(10, 10);
[alpha theta] = adaboost(1, X, y);
errors = 0;
for l = 1:size(y,1)
    x = X(l,:)
    label = adapred(alpha, theta, x);
    if label ~= y(l)
        errors = errors + 1
    end
end
e = errors
    
    