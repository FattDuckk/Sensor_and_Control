% 1. Create a synthetic 2D vessel-like shape
t = linspace(0, 4*pi, 500);
x = 10 + 3*cos(t) + rand(1, length(t)); % Perturb shape for non-perfect circle
y = t + 3*sin(t) + rand(1, length(t));

% Plot the vessel shape
figure; 
plot(x, y, 'k-'); 
axis equal; 
hold on;

% 2. Sample points from its boundary
num_samples = 100;
sample_indices = randperm(length(x), num_samples);
sample_points = [x(sample_indices)', y(sample_indices)'];

% Plot the sample points
plot(sample_points(:,1), sample_points(:,2), 'ro');

% 3. Compute the Voronoi diagram
[V, C] = voronoin(sample_points);

% 4. Visualize the Voronoi diagram and potential centerlines
for i = 1:length(C)
    vert_indices = C{i};
    for j = 1:length(vert_indices)-1
        % Ensure vertices are neither Inf nor NaN
        if all(~isinf(V(vert_indices, :))) & all(~isnan(V(vert_indices, :)))
            plot(V(vert_indices(j:j+1), 1), V(vert_indices(j:j+1), 2), 'b-');
        end
    end
end

xlabel('X'); ylabel('Y');
title('Voronoi-based Centerline Extraction in 2D');
% hold off;
