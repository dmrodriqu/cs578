F = 10;
featureSet = []
% for 1 to F
[x y] = createsepratingdata(10, 3,3); 
for f = 1:F
    % if f is not in the featureset
    if ismember(featureSet, f) ~= 1
        disp(featureSet);
        x([featureSet])
    end
    % put it in the featureset
    featureSet = union(featureSet, f);
    disp(featureSet);
end
