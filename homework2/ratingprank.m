% Input: number of iterations L
% number of labels k
% matrix X of features, with n rows (samples), d columns (features)
% X(i,j) is the j-th feature of the i-th sample
% vector y of labels, with n rows (samples), 1 column
% y(i) is the label (1 or 2 ... or k) of the i-th sample
% Output: vector theta of d rows, 1 column
% vector b of k-1 rows, 1 column
function [theta b] = ratingprank(L,k,X,y)
  theta = zeros(size(X,2),1);
  % size of number of labels - 1
  b = zeros(k-1,1);
  n = size(y,1);
  for l = 1:k-1
    b(l) = l;
  end
  for iter = 1:L
    for t = 1:n
        t
      E = {};
      sta = {}
      for l = 1:k-1
          if y(t) <= l
              stl = -1;
          else
              stl = 1;
          end
          dtp = stl * (dot(theta, X(t, :)') - b(l));
          sta{end+1} = stl;
          if dtp <= 0
              E{end+1} = l;
          end
      end
      if isempty(E) ~=  1
          temp = sum([sta{:}]) * X(t,:);
          theta = theta + sum([sta{:}]) * X(t,:)';
        for l = 1:size(E,2)
            b(l) = b(l) - stl;
        end
      end
    end
  end 
end
