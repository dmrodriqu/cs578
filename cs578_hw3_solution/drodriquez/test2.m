[X y] = createlinregdata(10, 1000);
L = 10;
alpha = zeros(L, 1);
theta = ones(L,1);
n = size(X,1);
d = size(X,2);
W = zeros(n,1);
for t = 1:n
    W(t) = 1/n
end
%for r = 1...L do

for r = 1:L
    % get min
    m = []
    for j = 1:d
        s = 0;
        for t = 1:n
            s = s + W(t) * y(t) * sign(X(t,j))
        end
        m = [-s m]
    end
    [epsilon, am] = min(m)
    theta(r) = am;
    if epsilon >= 0
        return
    end
    epsilon = max(epsilon, -0.99);
    alpha(r) = 1/2 * log((1-epsilon)/(1+epsilon));
    for t = 1:n
        W(t) = W(t) * exp(-alpha(r)*y(t)*sign(X(t,theta(r))));
    end
    z = sum(W);
    W = W/z;
end