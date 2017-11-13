function [ read_in_data ] = read_in_listings( filename )
%reads in the listings
[~,~,read_in_data] = xlsread(filename);
end

