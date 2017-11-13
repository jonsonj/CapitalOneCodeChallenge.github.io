listings = read_in_listings('listings.csv');
listing = listings(:,[1 20 40 42 44 49:57 61:67 72 77 80]);
listing = process_listings(listing);

geo_vs_ppp = listing(:,[6, 7, 15, 20]);
neigh_vs_price = listing(:, [3, 15]);
rating_vs_price = listing(:, [24, 23, 15]);
price_at_cord = listing(:, [6, 7, 15, 16, 22]);

generate_graph1(geo_vs_ppp);
generate_graph2(neigh_vs_price);
generate_graph3(rating_vs_price);
generate_cord_map(price_at_cord);