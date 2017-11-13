function [ useful_listings ] = process_listings( listings )
%Checks listing data for unuseful data

%Removes all listings with non accurate location
good_data = strcmp(listings, 't');
useful_listings = listings(good_data(:,8),:);

%removes all listings no in San Francsico
good_data = strcmp(useful_listings, 'San Francisco') == true;
useful_listings = useful_listings(good_data(:,4),:);
end

