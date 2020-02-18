function error = check4(X,y)
    alpha = kerdualsvm(X,y);
    error = 0;
    for i = 1:size(X,1)
        if kerpred(alpha,X,y,X(i,:)') ~= y(i)
            error = error + 1;
        end
    end
end