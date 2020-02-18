function errors = ploterr(n,step, k, x, y)
    s= n/step
    errorvec = zeros(s,1)
    k = 1;
    for i = 1:step:n
        errorvec(k) = check1(i, k, x, y);
        k = k+1
    end
    plot(errorvec(:,1)')
end