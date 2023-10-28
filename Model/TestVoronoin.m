clear 
close all

% Generate a cylinder mesh
[Z, Y, X] = cylinder(1, 50); % MATLAB's cylinder function returns 2D circles. We'll use X as height (Z-coordinate).
Z = Z * 5; % Stretch the cylinder in height

% Reshape data into vertex and face format
V = [X(:), Y(:), Z(:)];
F = delaunay(X(:), Y(:));

figure;
patch('Vertices', V, 'Faces', F, 'FaceColor', 'cyan', 'EdgeColor', 'none', 'FaceAlpha', 0.4);
axis equal; hold on;


%%

[VorVertices, ~] = voronoin(V);

% Filtering Voronoi vertices inside the cylinder
% For simplicity, we're just checking if the point's distance to origin (radius) is less than the cylinder's radius.
radius = 1;
insideIndices = find(sqrt(VorVertices(:,1).^2 + VorVertices(:,2).^2) <= radius & VorVertices(:,3) >= 0 & VorVertices(:,3) <= 5);

insidePoints = VorVertices(insideIndices, :);

scatter3(insidePoints(:,1), insidePoints(:,2), insidePoints(:,3), 'ro');

%%

% True centerline endpoints
centerline_start = [mean(V(:,1)), mean(V(:,2)), 0];
centerline_end = [mean(V(:,1)), mean(V(:,2)), 5];

% Plot it
plot3([centerline_start(1), centerline_end(1)], [centerline_start(2), centerline_end(2)], [centerline_start(3), centerline_end(3)], 'r-', 'LineWidth', 2);

