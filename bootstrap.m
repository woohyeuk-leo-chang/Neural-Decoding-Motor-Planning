function [bootstrap_std] = bootstrap(data, n_runs)
% bootstrap  Calculates a bootstrapped STD for a given 
%   
% Inputs
%   data : 1-dimensional vector 
%
%   n_runs : number of times to bootstrap
%
% Output
%   bootstrap_std : bootstrapped std value

    n_means = zeros(1, n_runs);
    n_count = length(data);

    for i=1:n_runs
        % resample with replacement
        curr_sample = randsample(data, n_count, true);
        curr_mean = mean(curr_sample);
        n_means(i) = curr_mean;
    end
    
    bootstrap_std = std(n_means);
end