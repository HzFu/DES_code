function [ Cue ] = DES_SaliencyCue( RGB_img, depth, para )
%RGBDT_SALIENCYCUE Summary of this function goes here
%   Detailed explanation goes here

% extract vector
[LAB_vector, DIS_vector]=DES_GetImVector(RGB_img);

% Lab color
LAB_vector = LAB_vector/max(LAB_vector(:));%Lab normalize to [-1,1]

% image coordinates
x=1-para.img_W/2:para.img_W/2;
Xvector=reshape(repmat(x,[para.img_H,1]),[para.img_vector_size,1]);
y=1-para.img_H/2:para.img_H/2;
Yvector=reshape(repmat(y,[para.img_W,1])',[para.img_vector_size,1]);
XY_vector = [Xvector, Yvector];
XY_vector = XY_vector/max(XY_vector(:))*0.5;%coordinate normalize to [-0.5,0.5]

imdvector = [LAB_vector, XY_vector];

% depth
Depth_vector = reshape(depth,para.img_vector_size,1);
Dep_vector = Depth_vector-min(Depth_vector(:));
Dep_vector = Dep_vector/max(Dep_vector(:))*2-1; % depth map normalize to [-1,1]
imdvector = [imdvector, Dep_vector];


% Kmeans cluster
[Cue.ClusterIdx, Cue.ClusterCenter] = kmeansPP(imdvector', para.cluster_num);
Cue.ClusterCenter = Cue.ClusterCenter'; Cue.ClusterIdx = double(Cue.ClusterIdx');

% saliency cue
Cue.Contrast2D = DES_GaussNorm(DES_2DContrastCue(Cue.ClusterCenter, Cue.ClusterIdx));
Cue.Distance2D  = DES_GaussNorm(DES_2DDistanceCue( Cue.ClusterIdx, DIS_vector, para)); 

Cue.DistanceDep = DES_GaussNorm(DES_DepDistanceCue(Depth_vector, Cue.ClusterIdx, para)); 
Cue.ContrastDep = DES_GaussNorm(DES_DepContrastCue(Depth_vector, Cue.ClusterIdx, Cue.ClusterCenter, para)); 


end

