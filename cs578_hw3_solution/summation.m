function [m,i] = summation(d,n,w,y,x)
mins = [];
for j = 1:d
    total = 0;
    for t = 1:n
         total = total + w(t) * y(t) * sign(x(t,j));
    end
    mins = [-total mins];
end
[m i] = min(mins);
end