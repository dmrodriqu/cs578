% Input: scalar q
% vector mu_pos of d rows, 1 column
% vector mu_neg of d rows, 1 column
% scalar sigma2_pos
% scalar sigma2_neg
% vector x of d rows, 1 column
% Output: label (+1 or -1)
function label = probcpredict(q,mu_pos,mu_neg,sigma2_pos,sigma2_neg,x)
    d = size(x,1);
    loq = log(q/(1-q));
    losigma =(d/2)*log(sigma2_pos/sigma2_neg);
    weightnormpos = (1/(2*sigma2_pos))*norm(x-mu_pos);
    weightnormneg = (1/(2*sigma2_neg))*norm(x-mu_neg);
    cond = loq - losigma - weightnormpos + weightnormneg;
    if cond > 0
        label = 1;
    else
        label = -1;
    end
end