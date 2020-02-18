function error = check3(X,y)
theta = linprimalsvm(X,y);
    error = 0;
    for i = 1:size(X,1)
        if linpred(theta, X(i,:)') ~= y(i)
            error = error + 1;
        end
    end
end