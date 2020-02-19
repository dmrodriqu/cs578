function s = loss(theta,X,y)
    p = zeros(size(X,1),1);
    for t = 1:size(X,1)
        p(t) = X(t,:)*theta; % prediction = <theta,x_t>
    end
    s = 0.5*(p-y)'*(p-y);  %loss = \sum_{t=1}^n 
end

