% Matlab demo for RGB-D + video saliency detection 

close all;clear;


addpath('./src');

% image set path
img_name = 'img';
RGB_path= ['./data/rgb_img/' img_name '.jpg'];
Depth_path= ['./data/depth_map/' img_name '.png'];
Result_path = FDS_mkdir('./data/result/');

% parameters
DES_para.cluster_num= 40; %clustering number 
DES_para.sigma2 = 0.4;
DES_para.gamma = 5;

% read RGBD data

RGB_img = imread(RGB_path);
depth_map = double(imread(Depth_path));

[DES_para.img_H, DES_para.img_W, DES_para.img_C] = size(RGB_img); 
DES_para.img_vector_size = DES_para.img_H* DES_para.img_W;

% compute cluster-based saliency cue
DES_Cue = DES_SaliencyCue( RGB_img, depth_map, DES_para );

% fusion
DES_Cue.FinalCue = DES_GaussNorm(DES_Cue.Contrast2D + DES_Cue.Distance2D + DES_Cue.DistanceDep + DES_Cue.ContrastDep);

% generate saliency map
DES_map = DES_GenerateMap(DES_para, DES_Cue);

% save result
imwrite(DES_map, [Result_path img_name '_DES.png'], 'png');
depth_temp = round((depth_map - min(depth_map(:)))./(max(depth_map(:)) - min(depth_map(:))).*255);
imwrite(depth_temp, jet(256), [Result_path img_name '_dep.jpg'], 'jpg');

% figure show
max_dep = max(depth_map(:));
figure,
subplot(1,3,1), imshow(RGB_img);
subplot(1,3,2), imshow(max_dep - depth_map, []);
subplot(1,3,3), imshow(DES_map);

