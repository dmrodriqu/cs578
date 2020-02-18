% Input: number of labels k
%        matrix X of features, with n rows (samples), d columns (features)
%            X(i,j) is the j-th feature of the i-th sample
%        vector y of labels, with n rows (samples), 1 column
%            y(i) is the label (1 or 2 ... or k) of the i-th sample
% Output: vector theta of d rows, 1 column
%         vector b of k-1 rows, 1 column
function [theta b] = ratingsvm(k,X,y)
    n = size(X,1); d = size(X,2); 
    s     = ones(n,k-1);
    for t = 1:n
        for l = 1:k-1
            if y(t) <= l
                s(t,l) = -1;
            end
        end
    end
    H = [eye(d) zeros(d,k-1);
        zeros(k-1,d) zeros(k-1)];
    f = zeros(d+k-1,1);
    % assemble A %
    M11 = [];
    for i = 1:n
        V = ones(k-1,d);
        for j = 1:k-1
            V(j,:) = -s(i,j) * X(i,:);
        end
        M11 = [M11;V];
    end
    
    M12 = [];
    for i = 1:n
        V = zeros(k-1);
        for j = 1:k-1
            V(j,j) = s(i,j);
        end
        M12 = [M12;V];
    end
    
    M21 = zeros(k-2,d);
    
    M22 = zeros(k-2,k-1);
    for i = 1:k-2
        M22(i,i) = 1;
        M22(i,i+1) = -1;
    end
    A = [M11 M12;M21 M22]; 
    c = [-ones(n*(k-1),1);zeros(k-2,1)];
    z = quadprog(H,f,A,c);
    theta = z(1:d,:);
    b = z(d+1:length(z),:);
end

