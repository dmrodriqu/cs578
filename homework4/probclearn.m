% Input: matrix X of features, with n rows (samples), d columns (features)
% X(i,j) is the j-th feature of the i-th sample
% vector y of labels, with n rows (samples), 1 column
% y(i) is the label (+1 or -1) of the i-th sample
% Output: scalar q
% vector mu_pos of d rows, 1 column
% vector mu_neg of d rows, 1 column
% scalar sigma2_pos
% scalar sigma2_neg
function [q, mu_pos, mu_neg, sigma2_pos, sigma2_neg] = probclearn(X,y)
    kpos = 0;
    kneg = 0;
    mu_pos = 0;
    mu_neg = 0;
    % get number of samples
    nsamples = size(X,1);
    d = size(X,2);
    % get total number of positive
    % and negative samples
    for t = 1:nsamples
        if y(t) == 1
            kpos = kpos + 1;
            mu_pos = mu_pos + X(t, :);
        else
            kneg = kneg + 1;
            mu_neg = mu_neg + X(t, :);
        end
    end
    q = kpos / nsamples;
    mu_pos = (1/kpos)* mu_pos;
    mu_neg = (1/kneg) * mu_neg;
    sigma2_pos = 0;
    sigma2_neg = 0;
    for t = 1:nsamples
        if y(t) == 1
            sigma2_pos = sigma2_pos + (norm(X(t,:) - mu_pos)^2);
        else
            sigma2_neg = sigma2_neg + (norm(X(t,:) - mu_neg)^2);
        end
    end
    sigma2_pos = (1/(d*kpos)) * sigma2_pos;
    sigma2_neg= (1/(d*kneg)) * sigma2_neg;
end
    
            