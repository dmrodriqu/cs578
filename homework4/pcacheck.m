function pcacheck(n,d,F)
    load hald
    [X,y] = createsepdata(n,d);
    ntrain = n*.80;
    % create train and test set
    X_train = X(1:ntrain,:);
    y_train = y(1:ntrain,:);
    X_test = X(ntrain:end, :);
    y_test = y(ntrain:end, :);
    
    [q, mu_pos, mu_neg, sigma2_pos, sigma2_neg] = probclearn(X_train,y_train);
    d = size(X_train,2);
    % 1 row d columns (d dimensions)
    dposrows = size(mu_pos,1);
    dnegrows = size(mu_neg,1);
    dposdim = size(mu_pos,2);
    dnegdim = size(mu_neg,2);
    
    %dposcheck - dims of mupos
    %dnegcheck - dims of muneg
    
    dposcheck = dposrows == 1 && dposdim == d;
    dnegcheck = dnegrows == 1 && dnegdim == d;
    
    % dimensions of both mu must be equivalent
    
    dposcheck == dnegcheck;
    
    % sizeSame - sigmas must be same size 
    % dimsSize = must be 1 by 1
    
    sizeSame = size(sigma2_pos) == size(sigma2_pos);
    dimsSame = size(sigma2_pos,1) == 1 && size(sigma2_pos,2) == 1;
    sigmacheck = sizeSame(1) == sizeSame(2) == dimsSame;
    
    % learning errors must be 0
    err = 0;
    for i= 1: size(X_train,1)
        
        % input into probcpredict transpose of mu_pos to get
        % 1 column with d rows
        % transpose of X row to make d rows 1 column
        % x(n) = [a,b,c,d ... ]
        % x(n)' = [a
        %          b...]
        
        label = probcpredict(q,mu_pos.',mu_neg.',sigma2_pos,sigma2_neg,X_train(i,:).');
        if label ~= y_train(i)
            err = err + 1;
        end
    end
    err
    learnError = err == 0;

    
    % checking pcalearn
    % dimensions
    [mu, Z] = pcalearn(F, X_train);
    mudims = size(mu);
    murows = mudims(1);
    mucols = mudims(2);
    dimsx = size(X_train);
    dimsxrows = size(1);
    dimsxcols = size(2);
    
    % number of rows in mu must be d
    murowcheck = murows == d;
    mucolcheck = mucols == 1;

    mudimscheck = murowcheck == mucolcheck;
    
    % checking dims of Z
    
    sizeZ = size(Z);
    rowsZ = sizeZ(1);
    colsZ = sizeZ(2);
    
    zrow = rowsZ == d;
    zcol = colsZ == F;
    
    Zdim = zrow == zcol;
    
    % checking problem 4
    
    
    [P] = pcaproj(X_test, mu, Z);
    xdims = size(X_test);
    xn = xdims(1);
    xd = xdims(2);
    
    %testing input dims
    
    xdimcheck = xd == d;
    mudim = size(mu);
    murows = mudim(1);
    mucol = mudim(2);
    
    murowcheck = murows == xd;
    mucolcheck = mucols == 1;
    
    indimcheck = murowcheck == mucolcheck == xdimcheck
    %testing output dims

    pdims = size(P);
    prows = pdims(1);
    pcols = pdims(2);
    
    % checking dimensions of P
    prowcheck = prows == xn;
    pcolcheck = pcols == F;
    pdimcheck = prowcheck == pcolcheck;
    
    
    
    testerr = 0;
    for i= 1: size(P,1)
        
        % input into probcpredict transpose of mu_pos to get
        % 1 column with d rows
        % transpose of X row to make d rows 1 column
        % x(n) = [a,b,c,d ... ]
        % x(n)' = [a
        %          b...]
        
        
        label = probcpredict(q,mu_pos(:, 1:F).',mu_neg(:,1:F).',sigma2_pos,sigma2_neg, P(i,:).');
        if label ~= y_test(i)
            testerr = testerr + 1;
        end
    end
    
    % check all
    p1 = dposcheck == dnegcheck == sigmacheck
    p2 = learnError
    p3 = mudimscheck == Zdim
    p4 = pdimcheck
    hwCheck = p1 == p2 == p3 == p4;
    testerr = testerr/ntrain
    hwCheck
    
    
    
end