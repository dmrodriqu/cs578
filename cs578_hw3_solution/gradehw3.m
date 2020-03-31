% CS578, Spring 2020, Instructor: Jean Honorio (jhonorio@purdue.edu)
% Grading script.

function [score] = gradehw3()
    rng(13,'twister');

    fprintf('Grading Started\n');
    res_file = fopen('result.txt', 'w');

    [score, dim_mis] = question1(res_file);
    score = score + question2(res_file);
    [totalscore, dm] =  question3_4(res_file);
    dim_mis = dim_mis | dm;
    score = score + totalscore;
    if dim_mis
        score = score - 0.5;
    end
    score = round(score, 1);

    fprintf(res_file, '\n\nYour Score = %f\n\n', score);
    fprintf('\n\nYour Score = %f\n', score);
    fprintf('Finished Grading \n');
    fprintf(res_file, 'Finished Grading \n');
end

%%%%%%%%%% Question 1 %%%%%%%%%%%%

function [score, dim_mis] = question1(res_file)
    load data.mat;
    score = 0;
    dim_mis = false;
    mul = 3.5;
    fprintf(res_file, '=========== Question 1 ==========\n');

    fprintf(res_file, 'Test case 1\n');
    [s, dm] = q1_testcase(linsepdata{1}, adaboost_score{1}, adaboost_L{1}, res_file);
    fprintf(res_file, 'Score = %.2f, Dim mismatch = %d\n\n', s * mul / 4, dm);
    score = score + s;
    dim_mis = dim_mis | dm;

    fprintf(res_file, 'Test case 2\n');
    [s, dm] = q1_testcase(linsepdata{2}, adaboost_score{2}, adaboost_L{2}, res_file);
    fprintf(res_file, 'Score = %.2f, Dim mismatch = %d\n\n', s * mul / 4, dm);
    score = score + s;
    dim_mis = dim_mis | dm;

    fprintf(res_file, 'Test case 3\n');
    [s, dm] = q1_testcase(linsepdata{3}, adaboost_score{3}, adaboost_L{3}, res_file);
    fprintf(res_file, 'Score = %.2f, Dim mismatch = %d\n\n', s * mul / 4, dm);
    score = score + s;
    dim_mis = dim_mis | dm;

    fprintf(res_file, 'Test case 4\n');
    [s, dm] = q1_testcase(linnonsepdata{1}, adaboost_score{4}, adaboost_L{2}, res_file);
    fprintf(res_file, 'Score = %.2f, Dim mismatch = %d\n\n', s * mul / 4, dm);
    score = score + s;
    dim_mis = dim_mis | dm;

    score = score / 4;
    score = score * mul;
    fprintf(res_file, 'Total = %.2f\n', score);
    fprintf(res_file, '==================================\n\n\n');

end

function [score, dim_mis] = q1_testcase(data, sol_score, L, res_file)
    score = 0;
    dim_mis = false;

    train_X = data.train.X;
    train_y = data.train.y;

    test_X = data.test.X;
    test_y = data.test.y;

    try
        [alpha, theta] = adaboost(L, train_X, train_y);
    catch ME
        fprintf(res_file, strcat(ME.identifier, '\n'));
        fprintf(res_file, strcat(ME.message, '\n'));
        return
    end

    % Check dimension mismatch.
    if numel(alpha) ~= L || numel(theta) ~= L
        fprintf(res_file, 'Invalid output.');
        return
    end

    if ~ all(size(alpha) == [L 1])
        dim_mis = dim_mis | true;
        alpha = reshape(alpha, L, []);
    end

    if ~ all(size(theta) == [L 1])
        dim_mis = dim_mis | true;
        theta = reshape(theta, L, []);
    end
    
    try
        pred = adapredall(alpha, theta, test_X, @soladapred);
        score = 1 - loss(test_y, pred);
    catch ME
        fprintf(res_file, strcat(ME.identifier, '\n'));
        fprintf(res_file, strcat(ME.message, '\n'));
        return
    end

    if score > sol_score
        score = sol_score;
    end

    score = score / sol_score;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%% Question2 %%%%%%%%%%%%%%%%%%
function score = question2(res_file)
    load data.mat;
    score = 0;
    mul = 1.5;

    fprintf(res_file, '=========== Question 2 ==========\n');

    fprintf(res_file, 'Test case 1\n');
    s = q2_testcase(linsepdata{1}, adaboost_sol{1}, adaboost_score{1}, adaboost_L{1}, res_file);
    fprintf(res_file, 'Score = %.2f\n\n', s * mul / 4);
    score = score + s;

    fprintf(res_file, 'Test case 2\n');
    s = q2_testcase(linsepdata{2}, adaboost_sol{2}, adaboost_score{2}, adaboost_L{2}, res_file);
    fprintf(res_file, 'Score = %.2f\n\n', s * mul / 4);
    score = score + s;

    fprintf(res_file, 'Test case 3\n');
    s = q2_testcase(linsepdata{3}, adaboost_sol{3}, adaboost_score{3}, adaboost_L{3}, res_file);
    fprintf(res_file, 'Score = %.2f\n\n', s * mul / 4);
    score = score + s;

    fprintf(res_file, 'Test case 4\n');
    s = q2_testcase(linnonsepdata{1}, adaboost_sol{4}, adaboost_score{4}, adaboost_L{2}, res_file);
    fprintf(res_file, 'Score = %.2f\n\n', s * mul / 4);
    score = score + s;

    score = score / 4;
    score = score * mul;
    fprintf(res_file, 'Total = %.2f\n\n', score);
    fprintf(res_file, '==================================\n\n\n');
end

function score = q2_testcase(data, sol, sol_score, L, res_file)
    score = 0;

    train_X = data.train.X;
    train_y = data.train.y;

    test_X = data.test.X;
    test_y = data.test.y;

    alpha = sol.alpha;
    theta = sol.theta;

    try
        pred = adapredall(alpha, theta, test_X, @adapred);
    catch ME
        fprintf(res_file, strcat(ME.identifier, '\n'));
        fprintf(res_file, strcat(ME.message, '\n'));
        return
    end
    score = 1 - loss(test_y, pred);
    if abs(score - sol_score) < 0.05
        score = 1;
    else
        score = 0;
        fprintf(res_file, 'solution accuracy: %.2f, submission accuracy: %.2f\n', sol_score, score);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%% Question 3, 4 %%%%%%%%%%%%%%%%%%%%
function [totalscore,  dim_mis] =  question3_4(res_file)
    entry = 99999 * ones(1, 22);
    totalscore = 0;
    all_data = cell(4, 1);
    dim_mis = false;
    
    for i = 0:3
        dataname = strcat('data' , int2str(i), '.mat');
        all_data{i+1, 1} = load(dataname);
    end

    for i = 0:3
        data = all_data{i+1,1};
        qscore = zeros(2, 1);
        
        fprintf(res_file, 'Test case %d\n', i+1);
        % Q3
        fprintf(res_file, '=========== Question 3 ==========\n');
        try
            testz = kfoldcv(10, data.X, data.y);
            
            % Check dimension mismatch.
            if numel(testz) ~= numel(data.z1) 
                fprintf(res_file, 'Invalid output.\n');
            end

            if ~ all(size(testz) == size(data.z1))
                fprintf(res_file, 'Dim mismatch = 1\n');
                dim_mis = dim_mis | true;
                testz = reshape(testz, size(data.z1));
            end
            
            entry(2+(i*5)) = max(abs(testz-data.z1));
            if (entry(2+(i*5)) <= 0.05)
                qscore(1) = 2.5;
            end
            fprintf(res_file, 'Score = %.2f\n\n', qscore(1));
        catch ME
            fprintf(res_file,'Q3 error\n');
            fprintf(res_file, strcat(ME.identifier, '\n'));
            fprintf(res_file, strcat(ME.message, '\n'));
        end

        % Q4
        fprintf(res_file, '=========== Question 4 ==========\n');
        try
            testz = bootstrapping(100, data.X, data.y);
            
            % Check dimension mismatch.
            if numel(testz) ~= numel(data.z2) 
                fprintf(res_file, 'Invalid output.\n');
            end

            if ~ all(size(testz) == size(data.z2))
                fprintf(res_file, 'Dim mismatch = 1\n');
                dim_mis = dim_mis | true;
                testz = reshape(testz, size(data.z2));
            end
            
            testmean = mean(testz);
            goldmean = mean(data.z2);
            entry(3+(i*5)) = max(abs(testmean-goldmean));
            if (entry(3+(i*5)) <= 0.05)
                qscore(2) = 2.5;
            end
            fprintf(res_file, 'Score = %.2f\n\n', qscore(2));
        catch ME
           fprintf(res_file,'Q4 error\n');
           fprintf(res_file, strcat(ME.identifier, '\n'));
           fprintf(res_file, strcat(ME.message, '\n'));
        end
    
        totalscore = totalscore + sum(qscore)/4;
    end
    fprintf(res_file, 'Score for 3,4 = %.2f\n\n', totalscore);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

