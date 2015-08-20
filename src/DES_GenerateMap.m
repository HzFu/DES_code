function [ FDS_map ] = DES_GenerateMap( DES_para, DES_Cue)
%FDS_GENERATEMAP Summary of this function goes here
%   Detailed explanation goes here

Saliency_temp= reshape(DES_Cue.ClusterIdx, DES_para.img_H, DES_para.img_W);
for j=1:DES_para.cluster_num
    Saliency_temp(Saliency_temp==j)=DES_Cue.FinalCue(j);
end
FDS_map = imfilter(Saliency_temp, fspecial('gaussian', [3, 3], 3));


end

