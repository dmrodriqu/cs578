% CS578, Spring 2020, Instructor: Jean Honorio (jhonorio@purdue.edu)

function l = loss(y, preds)
l = 1 - sum(y == preds)/numel(y);
end
