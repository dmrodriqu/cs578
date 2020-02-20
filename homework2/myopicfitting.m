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
    S = []
    thetaS = []
    for f = 1 : F
        