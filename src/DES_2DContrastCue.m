function [ Sal_weight ] = DES_2DContrastCue( ctrs ,idx)
%GETSALWEIGHT Summary of this function goes here
    con_ctrs = ctrs(:,1:3);
    pos_ctrs = ctrs(:,4:5)/max(max(ctrs(:,4:5)));
    bin_num=size(con_ctrs,1);
    bin_weight=zeros(bin_num,1);
    for i=1:bin_num
        bin_weight(i)=size(find(idx==i),1);
    end
    bin_weight=bin_weight/size(idx,1);
    Y = squareform(pdist(con_ctrs)).*repmat(bin_weight, [1, bin_num]).*exp(-squareform(pdist(pos_ctrs))/0.4);
    Sal_weight=sum(Y)';
end