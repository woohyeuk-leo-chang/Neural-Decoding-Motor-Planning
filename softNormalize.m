function [norm_mat] = softNormalize(data, c)
% softNormalize  performs soft normalization on matrix given constant
%   
% Inputs
%   data : 2D matrix 
%
%   c : constant for soft normalization
%
% Output
%   norm_mat : soft-normalized matrix

    col_range = range(data, 1) + c;
    col_mat = repmat(col_range, size(data,1), 1);
    norm_mat = data ./ col_mat;
end