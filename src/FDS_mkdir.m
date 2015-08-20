function [ datadir ] = FDS_mkdir( datadir )
%MKDIR_FHZ Summary of this function goes here
%   Detailed explanation goes here

    if (~exist(datadir, 'dir'))
        mkdir(datadir);
    end

end

