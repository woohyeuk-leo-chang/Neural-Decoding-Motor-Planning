function [acc_list, mean_acc] = SVM(X, y, nFold)
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

    svm_y = y*-2 + 1;
    svm_mdl = fitcsvm(X, svm_y);
    cv_svm_mdl = crossval(svm_mdl, 'kFold', nFold);
    L = kfoldLoss(cv_svm_mdl, 'Mode','individual');
    acc_list = 1 - L;
    mean_acc = mean(acc_list);
end