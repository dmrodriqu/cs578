    function errors = check1(L,k,X,y)
        [theta b] = ratingprank(L,k,X,y);
        %[theta b] = ratingsvm(k,X,y);
        errors = 0;
        for i = 1:size(X,1)
            pred = ratingpred(k,theta,b,X(i,:)');
            act  = y(i);
            if ratingpred(k,theta,b,X(i,:)') ~= y(i)
                errors = errors + 1;
            end
        end
    end

