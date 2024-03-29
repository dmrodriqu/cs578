% dylan rodriquez
% Input: number of samples n
% number of features d
% number of labels k
% Output: matrix X of features, with n rows (samples), d columns (features)
% X(i,j) is the j-th feature of the i-th sample
% vector y of labels, with n rows (samples), 1 column
% y(i) is the label (1 or 2 ... or k) of the i-th sample
% Example on how to call the function: [X y] = createsepratingdata(10,2,3);
function [X y] = createsepratingdata(n,d,k)
  if n < k
    error('n should be at least k');
end
X = rand(n,d);
y = zeros(n,1);
i = 0;
for l = 1:k
  j = ceil(l/k*n);
  X(i+1:j,1) = X(i+1:j,1) + 1.5*l;
  y(i+1:j) = l;
  i = j;
end

U = orth(rand(d));
X = X*U;
