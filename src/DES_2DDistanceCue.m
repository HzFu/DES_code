function [ Dis_weight ] = DES_2DDistanceCue( idx, DisVector, para )
%GETPOSITIONW Summary of this function goes here
%   Detailed explanation goes here

Dis_weight=zeros(para.cluster_num,1);

for i=1:para.cluster_num
    x=sum(DisVector(idx==i))/size(DisVector(idx==i),1);
    Dis_weight(i) = exp(-x.^2/(para.img_W^2));
end

end

