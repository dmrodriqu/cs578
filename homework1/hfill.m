function Hmsat = hfill(X, y)
    n = size(X, 1);
    Hmsat = zeros(n);
    for i = 1:n
        for j = 1:n
            Hmsat(i,j) = y(i)*y(j)*K(X(i,:)',X(j,:)');
        end
    end
end

