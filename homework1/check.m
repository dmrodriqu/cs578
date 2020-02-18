function error = check(L,X,y)
    n = size(X,1);
    theta = linperceptron(L,X,y);
    error = 0;
    for i = 1:n
        if linpred(theta, X(i,:)') ~= y(i)
            error = error + 1;
        end
    end
end

