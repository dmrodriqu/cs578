%% dylan rodriquez
function tj = linmin(X,y,j, thetaS)
    calcx = X(:,j);
    if isempty(thetaS)
        thetaS = zeros(size(X,1),1);
    end
    calcy = y-dot(thetaS,calcx);

    % argmin 1/2 for linreg
    tj = linreg(calcx, calcy);
end