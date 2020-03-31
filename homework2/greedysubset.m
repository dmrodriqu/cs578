% Input: number of features F
%               feat_1   feat_d
%      x(t,s) = [1 ........d] for features in S(t)
%   matrix X of features, with n rows (samples), d columns (features)
%       
%            1 ............d
%       x = [                   1
%                               .
%                               .
%                               n
%                           ]
%       X(i,j) is the j-th feature of the i-th sample
%   vector y of scalar values, with n rows (samples), 1 column
%                
%       x = [    1
%                .
%                .
%                n
%                   ]
%       y(i) is the scalar value of the i-th sample
% Output: vector of selected features S, with F rows, 1 column
%   vector thetaS, with F rows, 1 column
%   thetaS(1) corresponds to the weight of feature S(1)
%   thetaS(2) corresponds to the weight of feature S(2)
%   and so on and so forth
function [S thetaS] = greedysubset(F,X,y)
    S = [];
    if size(X,1) < F
        error('f is greater than number of features');
    end
    for f = 1 : F
        % for every feature j in x
        theta = zeros(size(S));
        % 1 
        js = []
        for j = 1:size(X,2)
            % if it is not in s
            if ~ismember(j, S)
                % argmin
                xfeat = X(:,[union(S,j)])
                thetahat = linreg(xfeat, y);
                % calc sum
                sm = 0;
                for t = 1:size(y,1)
                    t
                    temp = xfeat(t,:);
                    dp = dot(thetahat, xfeat(t,:)');
                    sm = sm + 1/2*(y(t) - dp).^2;
                end
            end
                js = [js;[sm j]];
            end
        % argmin
        %  .1294 1 
        %  .2222 2 
        sorted=sortrows(js);
        % unions
        feat = sorted(1,2);
        sorted(1,:) = [];
        S = [S feat];
    end
    thetaS = linreg(X(:,S),y);
end

                
    
    
    
    