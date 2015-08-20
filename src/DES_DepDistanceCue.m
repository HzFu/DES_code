function [ Dep_weight ] = DES_DepDistanceCue( Depth_vector, idx, para)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

DOF = max(Depth_vector)-min(Depth_vector);

meandepth = zeros(para.cluster_num,1);
for i=1:para.cluster_num
    meandepth(i) = sum(Depth_vector(idx==i))/size(find(idx==i),1);
end    
 
Dep_weight = (max(meandepth)-meandepth).^(para.gamma/DOF);%

end

