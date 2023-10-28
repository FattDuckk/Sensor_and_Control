% Parameters for the cylinder
radius = 1;
height = 5;
num_points = 1000;

% Generate random points on the surface of a cylinder
theta = 2 * pi * rand(num_points, 1);
z = height * rand(num_points, 1);
x = radius * cos(theta);
y = radius * sin(theta);
points = [x, y, z];

% Compute Delaunay triangulation
DT = delaunayTriangulation(points);

% Plot the cylinder points
scatter3(points(:,1), points(:,2), points(:,3), '.');
hold on;

% Compute and plot the Voronoi diagram based on the triangulation
[V, r] = voronoiDiagram(DT);
for i = 1:numel(r)
    if all(r{i} ~= 1)   % Exclude cells that are unbounded
        patch(V(r{i},1), V(r{i},2), V(r{i},3), 'g', 'FaceAlpha', 0.3);
    end
end

xlabel('X');
ylabel('Y');
zlabel('Z');
axis equal;
grid on;
title('Voronoi Diagram of a 3D Cylinder');
