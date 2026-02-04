function [null_acc_list, p_val] = MCStat(X, y, n_runs, true_acc, classifier_type)
% logisticRegression  performs ElasticNet-penalized logistic regression
%   
% Inputs
%   X : 2D matrix with [trial feature] format
%
%   y : class labels (in binary format)
%
%   n_runs : number of runs to perform null distribution simulation
%
%   true_acc : true classification accuracy that will be compared against
%   the null distribution
%
% Output
%   p_val : p value

    null_acc_list = zeros(1, n_runs);
    
    % shuffle the labels and re-run the classification to achieve null
    % distribution
    parfor i=1:n_runs
        shuffled_y = y(randperm(length(y)));
        if classifier_type == "LogisticRegression"
            [~, shuffled_acc] = logisticRegression(X, shuffled_y, 5);
        else
            [~, shuffled_acc] = SVM(X, shuffled_y, 5);
        end
        null_acc_list(i) = shuffled_acc;
    end
    
    % calculate p-value
    p_val = (sum(null_acc_list > true_acc)+1) / (n_runs+1);
end