function a = constructa(x,y)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
n = size(x,1);
d = size(x,2);
a = zeros(n,d);
disp(a);
for i = 1:n
    for j = 1:d
        a(i,j) = -y(i)*x(i,j);
    end
end
end

