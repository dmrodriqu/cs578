% Input: number of iterations L
% matrix X of features, with n rows (samples), d columns (features)
% X(i,j) is the j-th feature of the i-th sample
% vector y of labels, with n rows (samples), 1 column
% y(i) is the label (+1 or -1) of the i-th sample
% Output: vector alpha of n rows, 1 column
function alpha = kerperceptron(L,X,y)
    alpha = zeros(size(X,1),1);
    n = size(X, 1);
    for iter = 1:L
        for t = 1:n
            if y(t)*sumkernel(alpha,y,X,X(t,:))<=0
                alpha(t) = alpha(t) + 1;
            end
        end
    end
end              