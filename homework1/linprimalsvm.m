% Input: matrix X of features, with n rows (samples), d columns (features)
% X(i,j) is the j-th feature of the i-th sample
% vector y of labels, with n rows (samples), 1 column
% y(i) is the label (+1 or -1) of the i-th sample
% Output: vector theta of d rows, 1 column
function theta = linprimalsvm(X,y)
n = size(X,1);
d = size(X,2);
H = eye(d);
f = zeros(d,1);
b = ones(n,1)*-1;
A = constructa(X,y);
theta = quadprog(H,f,A,b);
end
