function [cv_mat] = cvPCA(data, nFold, nComponents)
% cvPCA  performs cross validated PCA
%   
% Inputs
%   data : 2D matrix 
%
%   nFold : number of CV folds to perform
%
%   nComponents : number of components for PCA
%
% Output
%   cv_mat : matrix of dimension [nFold, nComponents] with errors

    % cross validate PCA
    c = cvpartition(length(data), "KFold", nFold);
    cv_mat = zeros(nFold, nComponents);
    
    for i=1:nFold
        % get corresponding data split
        curr_train_X = data(training(c,i),:);
        curr_test_X = data(test(c,i),:);
        
        % get mean firing rates for each neuron
        curr_train_means = mean(curr_train_X, 1);
    
        % run PCA on training set
        [coeff, ~, ~] = pca(curr_train_X, "NumComponents", nComponents);
        
        % for each dimension
        for d=1:nComponents
            % on test set, do leave-one-out neuron prediction
            curr_nUnits = size(curr_test_X,2);
            all_units = 1:curr_nUnits;
            unit_errs = zeros(1, curr_nUnits);
    
            % for each unit
            for n=1:curr_nUnits
                % use regression to estimate low-D state X while missing neuron n
                % from data Y
                curr_inds = all_units~=n;
                Y = curr_test_X(:,curr_inds);
                L = coeff(curr_inds,1:d);
                Y_tilda = Y - curr_train_means(curr_inds);
                X_hat = Y_tilda * L * inv(L'*L);
        
                % use estimated X and relationship to neuron n to guess n's firing
                Y_hat = X_hat * coeff(n,1:d)' + curr_train_means(n);
        
                % calculate MSE
                err = immse(curr_test_X(:,n), Y_hat);
                unit_errs(n) = err;
            end
            
            % average error for given dimensionality
            mean_err = mean(unit_errs);
            cv_mat(i,d) = mean_err;
        end
    end
    
end