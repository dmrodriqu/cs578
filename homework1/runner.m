function out = runner(L, x, y)
    out = zeros(L+1,1);
    for i = 0:L
        out(i+1) =  check2(i, x, y);
    end
end

