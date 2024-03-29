% Input: number of features F
% matrix X of features, with n rows (samples), d columns (features)
% X(i,j) is the j-th feature of the i-th sample
% vector y of scalar values, with n rows (samples), 1 column
% y(i) is the scalar value of the i-th sample
% Output: vector of selected features S, with F rows, 1 column
% vector thetaS, with F rows, 1 column
% thetaS(1) corresponds to the weight of feature S(1)
% thetaS(2) corresponds to the weight of feature S(2)
% and so on and so forth
function [S thetaS] = myopicfitting(F,X,y)
    S = [];
    thetaS = [];
    predictions = zeros(size(X,1));
    
    if size(X,2) < F
        error('f is greater than number of features');
    end
    for f = 1 : F
        % for every feature j in x
        % 1 
        dja = [];
        for j = 1:size(X,2)
            % if j not in s linreg
            if ~ismember(j, S)
                % sum of (y - prediction)
                % 
                if isempty(thetaS)
                    predictions = zeros(size(X,1),1);
                else
                    % populate entire vector of predictions for s
                    % populate entire vector of y
                    X_S = X(:,S);
                    for i = 1:size(X,1)
                        predictions(i) = dot(X_S(i,:),thetaS);
                    end
                end
                calcy = y - predictions;
                dj = -sum(calcy .* X(:,j));
                dja = [dja;[abs(dj) j]];
            end
        end
        sorted = sortrows(dja,1);
        v = sorted(size(dja,1),:);
        jh = v(2);
        S = [S jh];
        theta = linreg(X(:,jh),calcy);
        thetaS = [thetaS theta];
    end
    S = S'
    thetaS = thetaS'
end