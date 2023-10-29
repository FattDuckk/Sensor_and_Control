clear 
close all

% Sample 3D vertices for Voronoi
points = [1 2 3; 3 4 5; 6 1 2; 8 7 6; 9 5 4];

% Sample 3D model points and faces (replace these with your actual model data)
modelPoints = [0 0 0; 1 0 0; 1 1 0; 0 1 0; 0.5 0.5 1];
modelFaces = [1 2 5; 2 3 5; 3 4 5; 4 1 5; 1 2 3; 2 3 4];

% Compute 3D Voronoi vertices and regions
[V, C] = voronoin(points);


figure;
hold on;

% Plot the model using patch
patch('Faces', modelFaces, 'Vertices', modelPoints, 'FaceColor', 'g', 'FaceAlpha', 0.6, 'EdgeColor', 'none');

%%
% Plot Voronoi vertices
plot3(V(:,1), V(:,2), V(:,3), 'b.'); % Voronoi vertices in blue

% Plot Voronoi cells
for k = 1:length(C)
    region = C{k};
    
    % Eliminate any reference to the point at infinity (often denoted by 1)
    region = region(region ~= 1);
    
    % For visualization purposes, use 'convhull' to get a convex hull of the cell 
    if length(region) > 3 % Need at least 4 points to form a tetrahedron in 3D
        K = convhull(V(region,1), V(region,2), V(region,3));
        
        % Extract vertices for each face of the convex hull and plot using patch
        for j = 1:size(K, 1)
            x = V(region(K(j,:)), 1);
            y = V(region(K(j,:)), 2);
            z = V(region(K(j,:)), 3);
            patch(x, y, z, 'c', 'FaceAlpha', 0.5, 'EdgeColor', 'none');
        end
    end
end

axis equal;
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
title('3D Model and Voronoi Diagram with Patch');
view(3);  % Set a 3D view
lighting gouraud;  % Apply Gouraud lighting for a smoother appearance
camlight;  % Add a light source for better visualization
hold off;
