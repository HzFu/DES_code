function [ Depsal_weight ] = DES_DepContrastCue( Depth_vector,idx,ctrs,para)
%GETSALWEIGHT Summary of this function goes here


    pos_ctrs = ctrs(:,4:5)/max(max(ctrs(:,4:5)));%mean coordinate
    poi = squareform(pdist(pos_ctrs));
    % ppoi = poi.^(-1);
    % ppoi(ppoi==Inf)=0;%self distance is 0
    bin_num = para.cluster_num;
    Depsal_weight = zeros(bin_num,1);
    bin_weight = zeros(bin_num,1);
    for i=1:bin_num% mean depth
        Depsal_weight(i) = sum(Depth_vector(idx==i))/size(find(idx==i),1);
    end    
    dismatrix = zeros(bin_num);
    for i=1:bin_num
        for j=1:bin_num
            dismatrix(j,i)=Depsal_weight(j)-Depsal_weight(i);
        end
    end

    for i=1:bin_num% number of pixels
        bin_weight(i)=size(find(idx==i),1);
    end
    bin_weight=bin_weight/size(idx,1);
    Y = dismatrix.*repmat(bin_weight, [1, bin_num]).*exp(-poi/para.sigma2);

    Depsal_weight=sum(Y)';
end
