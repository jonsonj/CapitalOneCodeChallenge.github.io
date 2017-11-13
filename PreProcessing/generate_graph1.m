function [] = generate_graph1( geo_vs_ppp )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
geo_vs_ppp = sortrows(geo_vs_ppp);
latitude = cell2mat(geo_vs_ppp(:, 1));
longitude = cell2mat(geo_vs_ppp(:, 2));
price = cell2mat(geo_vs_ppp(:, 3));
people = cell2mat(geo_vs_ppp(:, 4));
ppp = price ./ people;

figure;
graph = scatter3(longitude, latitude, ppp,'r', '.');
title('Cost of Room Per Person based on Longitude and Latitude');
xlabel('Longitude');
ylabel('Latitude');
zlabel('Price per person');
ylim([37.65, 37.85]);
zlim([0 1000]);
saveas(graph, 'gvp_graph', 'jpg');
end

