% Input: number of bootstraps B
% matrix X of features, with n rows (samples), d columns (features)
% vector y of scalar values, with n rows (samples), 1 column
% Output: vector z of B rows, 1 column
function z = bootstrapping(B,X,y)
    n = size(X,1);
    z = zeros(size(B,1));
    for i = 1:B
        u = zeros(n, 1);
        s = [];
        for j = 1:n
            k = unidrnd(n);
            u(j) = k;
            s = union(s, k);
        end
        T = setdiff(1:n, s);
        thetahat = linreg(X(u, :),y);
        tmag = T*T';
        total = 0;
        for tx = 1:length(T)
            tnum = T(tx);
            true = y(tnum);
            pred = dot(thetahat, X(tnum,:));
            su = (true - pred).^2;
            total = total + su;
        end
        z(i) = 1/tmag * total;
    end
    z = z';
    histogram(z)
end