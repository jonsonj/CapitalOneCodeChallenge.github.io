function [] = generate_graph2( neigh_vs_price )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
neigh_vs_price = sortrows(neigh_vs_price);
neighs = neigh_vs_price(:,1);
groups = findgroups(neighs);
neighs = unique(neighs);
prices = neigh_vs_price(:,2);
prices = cell2mat(prices);
average = splitapply(@mean, prices, groups);
med = splitapply(@median, prices, groups);
data = [average, med];
neighs = categorical(neighs);

figure;
graph = bar(neighs, data);
graph(1).FaceColor = 'b';
title('Prices of AirBnb based on Neighborhood');
xlabel('Neighborhoods');
ylabel('Prices');
legend('Average', 'Median')
saveas(gcf, 'nvp_graph', 'jpg');
end

