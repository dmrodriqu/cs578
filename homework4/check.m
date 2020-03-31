function err = check(X, y)
     [q, mu_pos, mu_neg, sigma2_pos, sigma2_neg] = probclearn(X,y);
     err = 0;
     for i= 1: size(X,1)
        label = probcpredict(q,mu_pos.',mu_neg.',sigma2_pos,sigma2_neg,X(i,:).');
        if label ~= y(i)
            err = err + 1;
        end
     end
     err