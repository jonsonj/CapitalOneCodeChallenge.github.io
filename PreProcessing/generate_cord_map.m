function [ ] = generate_cord_map( price_at_cord )
%Generates csv files for calculating weekly revenue and ideal price

%removes all listings that have had no bookings
price_at_cord = cell2mat(price_at_cord);
no_bookings = price_at_cord(:,5) < 30;
price_at_cord = price_at_cord(no_bookings, :);

%calcuates weekly prices for listings with no weekly price
no_weekly_price = isnan(price_at_cord(:, 4));
price_at_cord(no_weekly_price,4) = price_at_cord(no_weekly_price,3) .* 7;
price_at_cord = sortrows(price_at_cord);

%splits all relevent latitude and longituds into 10 parts
[N , lat_edges] = histcounts(price_at_cord(:,1), 10);
[N , long_edges] = histcounts(price_at_cord(:,2), 10);

lat_and_long = [lat_edges; long_edges];

weekly_price = price_at_cord(:, [1, 2, 4, 5]);
weekly_price(:, 3) = weekly_price(:, 3) .* (weekly_price(:, 4) ./ 30);
weekly_price = weekly_price(:, [1, 2 3]);

weekly_rev_data = zeros(10);
ideal_price_data = zeros(10);
%loops through group of the longitude
for i = 1:10
    weekly_row_data = zeros(1,10);
    ideal_row_data = zeros(1,10);
    %loops through group of latitude
    for j = 1:10
        lat_values = (price_at_cord(:, 1) >= lat_edges(i));
        lat_values = lat_values & (price_at_cord(:, 1) < lat_edges(i + 1));
        long_values = (price_at_cord(:, 2) >= long_edges(j));
        long_values = long_values & (price_at_cord(:, 2) < long_edges(j + 1));
        value_needed = lat_values & long_values;
        
        %finds weekly revnue and ideal prices for each geolocial location
        rev_per_week = weekly_price(value_needed, 3);
        prices = price_at_cord(value_needed, 3);
        if isempty(rev_per_week)
            weekly_row_data(1, j) = 0;
            ideal_row_data(1, j) = 0;
        else
            weekly_row_data(1, j) = mean(rev_per_week);
            ideal_row_data(1, j) = max(prices);
        end
    end
    no_info = weekly_row_data == 0;
    weekly_row_data(no_info) = round(mean(weekly_row_data(~no_info)));
    weekly_rev_data(i,:) = weekly_row_data;
    
    no_info = ideal_row_data == 0;
    ideal_row_data(no_info) = round(mean(ideal_row_data(~no_info)));
    ideal_price_data(i, :) = ideal_row_data;
end

%generates csv files
csvwrite('cordinates.csv', lat_and_long);
csvwrite('weekly_rev.csv', weekly_rev_data);
csvwrite('ideal_price.csv', ideal_price_data);
end

