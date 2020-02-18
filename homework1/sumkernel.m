function res = sumkernel(a,y,x,xt)
res = 0;
for i=1:size(a,1)
    res = res +(a(i) * y(i)) * K(x(i,:)',xt');
end