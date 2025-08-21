function adj_matrix = AdjMatrix(coords, threshold)
    num_points = size(coords, 1);
    adj_matrix = zeros(num_points, num_points);
    
    for i = 1:num_points
        for j = i+1:num_points
            distance = norm(coords(i,:) - coords(j,:));
            if distance < threshold
                adj_matrix(i,j) = 1;
                adj_matrix(j,i) = 1;  % Since it's undirected
            end
        end
    end
end