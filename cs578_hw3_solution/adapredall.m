% CS578, Spring 2020, Instructor: Jean Honorio (jhonorio@purdue.edu)

function labels = adapredall(alpha, theta, X, predfunc)
n = size(X,1);
labels = ones(n,1);
for t = 1:n
    labels(t) = predfunc(alpha, theta, X(t,:)');
end
end % end of function

