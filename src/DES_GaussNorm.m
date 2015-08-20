function [ norm_vector ] = DES_GaussNorm( vector )
%GAUSS_NORMAL Summary of this function goes here
%   Detailed explanation goes here

% output_args = exp(-(vector-max(vector)).^2/((max(vector)-min(vector)/2)^2));

mean_v = (max(vector)-min(vector))/2;
max_v = max(vector);
norm_vector = exp(-(vector- max_v).^2/(mean_v^2));

% output_args=DES_Get_Gaussmf(vector,[(max(vector)-min(vector))/2 max(vector)]);

end

