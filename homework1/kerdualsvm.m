% Input: matrix X of features, with n rows (samples), d columns (features)
% X(i,j) is the j-th feature of the i-th sample
% vector y of labels, with n rows (samples), 1 column
% y(i) is the label (+1 or -1) of the i-th sample
% Output: vector alpha of n rows, 1 column
function alpha = kerdualsvm(X,y)
n = size(X,1);
f = ones(n,1);
z = zeros(n,1);
H = hfill(X,y);
alpha = quadprog(H, -f,[],[],[],[],z);
end