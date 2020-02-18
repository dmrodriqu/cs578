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
  s = ones(size(X,1),k-1);
  for t = 1:size(X,1)
    for l = 1:k-1
        if y(t) <= l
            s(t,l) = -1;
        end
    end
  end
  for iter = 1:L

    for t = 1:n
        E = {}; 
        
        for l = 1:k-1
            if s(t,l)* (dot(theta, X(t, :)') - b(l)) <= 0
                E{end+1} = l;
            end
        end
        se = size(E,2);
        if isempty(E) ~=  1   
          
          sm = 0;
          for l = 1:se
              sm = sm + s(t, E{l});
              theta = theta + sm * X(t,:)';
          end
          for l = 1:se
            b(E{l}) = b(E{l}) - s(t,E{l});
          end
        end
    end
  end 
end
