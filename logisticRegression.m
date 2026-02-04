function [acc_list, mean_acc] = logisticRegression(X, y, nFold)
% logisticRegression  performs ElasticNet-penalized logistic regression
%   
% Inputs
%   X : 2D matrix with [trial feature] format
%
%   y : class labels (in binary format)
%
%   nFold : number of K-folds 
%
% Output
%   acc_list : a mean classification accuracy across n folds

    % set up k-Fold CV
    c = cvpartition(size(X,1), "KFold", nFold);
    acc_list = zeros(1, nFold);

    for i=1:nFold
        % get corresponding data split
        curr_train_X = X(training(c,i),:);
        curr_train_y = y(training(c,i));
        curr_test_X = X(test(c,i),:);
        curr_test_y = y(test(c,i));
    
        % fit the logistic regression model
        [B,FitInfo] = lassoglm(curr_train_X, curr_train_y, 'binomial', ...
                               'Alpha',0.1, 'CV',5);
        % predict
        idxLambdaMinDeviance = FitInfo.IndexMinDeviance;
        B0 = FitInfo.Intercept(idxLambdaMinDeviance);
        coef = [B0; B(:, idxLambdaMinDeviance)];
        yhat = glmval(coef, curr_test_X, 'logit');
        yhat = yhat >= 0.5;
        % assess accuracy
        acc = sum(curr_test_y == yhat) / length(curr_test_y);
        acc_list(i) = acc;
    end

    mean_acc = mean(acc_list);

    
    
end