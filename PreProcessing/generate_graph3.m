function [] = generate_graph3( rating_vs_price )
%Generates thir graph of rating vs price

rating_vs_price = cell2mat(rating_vs_price);
rating_vs_price = sortrows(rating_vs_price);
rating_vs_price(isnan(rating_vs_price)) = 0;

%Splits listings based on rating
[bincounts,ind] = histc(rating_vs_price(:,1), [0:10:100]);
data = [];

%Calcuates the price for each rating score
for c = 1:size(bincounts)
    indices = ind == c;
    num_of_reviews = sum(rating_vs_price(indices, 2));
    sum_of_prices = sum(rating_vs_price(indices, 2) .* rating_vs_price(indices, 3));
    mean = sum_of_prices / num_of_reviews;
    data = [data; 10 * (c - 1), mean];
end

figure;
bar(data(:,1), data(:,2));
title('Rating of an Airbnb Listing vs Their Prices')
xlabel('Total Rating Score');
ylabel('Average Price');
saveas(gcf, 'rvp_graph', 'jpg');
end

