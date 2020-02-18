function error = check(L,k, X,y)
    n = size(X,1);
    [theta, b ] = ratingprank(L,k,X,y);
    error = 0;
    for i = 1:n
        if linpred(theta, X(i,:)') ~= y(i)
            error = error + 1;
        end
    end
end

