% dylan rodriquez
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
function [S thetaS] = forwardfitting(F,X,y)
  S = [];
  thetaS = [];
  predictions = zeros(size(X,1));
    if size(X,2) < F
        error('f is greater than number of features');
    end
    for f = 1 : F
        % for every feature j in x
        % 1 
        js = [];
        for j = 1:size(X,2)
            % if j not in s linreg
            if ~ismember(j, S)
                % calculate x and y for linreg
                calcx = X(:,j);
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
                calcy = y-predictions;    
                
                % argmin 1/2 for linreg
                tj = linreg(calcx, calcy); 
                % calc sum
                % compute a vector of predictions
                % loss is sum((predictions - calcy)^2)
                tj_xj = tj*X(:,j);
                sm = 0.5*sum((calcy - tj_xj).^2);
            end
            js = [js;[sm j tj]];
        end
        sorted=sortrows(js);
        % unions
        feat = sorted(1,2);
        sfeat = sorted(1,3);
        sorted(1,:) = [];
        S = [S feat];
        thetaS = [thetaS sfeat];
    end
    S = S';
    thetaS = thetaS';
end