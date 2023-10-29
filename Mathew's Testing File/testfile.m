clc;
clear;
close all;

load Mesh_Soft_EM_Mod_0601.mat;
%%
load Mesh_Soft_EM_Mod_0601.mat;
trisurf(tri, ver(:,1), ver(:,2), ver(:,3));
xlabel('X'); ylabel('Y'); zlabel('Z');
num_samples = 1000; % Adjust as needed
sample_indices = randperm(size(ver, 1), num_samples);
sample_points = ver(sample_indices, :);
[V, C] = voronoin(sample_points);
hold on;
for i = 1:length(C)
    vert = V(C{i}, :);
    K = convhull(vert);
    trisurf(K, vert(:,1), vert(:,2), vert(:,3), 'FaceColor', 'none', 'EdgeColor', 'b');
end
hold off;


%%
load Mesh_Soft_EM_Mod_0601.mat;
figure;
patch('Faces', tri, 'Vertices', ver, 'FaceColor', [0.8, 0, 0],'facealpha',0.3, 'EdgeColor', 'none');
xlabel('X'); ylabel('Y'); zlabel('Z');
axis equal;
lighting gouraud;
camlight;

num_samples = 1000; % Adjust as needed
sample_indices = randperm(size(ver, 1), num_samples);
sample_points = ver(sample_indices, :);


[V, C] = voronoin(sample_points);

hold on;
%%
hold on;
for i = 1:length(C)
    vert = V(C{i}, :);
    
    % Skip cells with infinite or NaN vertices
    if any(isinf(vert(:)) | isnan(vert(:)))
        continue;
    end
    
    K = convhull(vert);
    patch('Faces', K, 'Vertices', vert, 'FaceColor', 'none', 'EdgeColor', 'b');
end
%%
clc;
clear;
close all;

load Mesh_Soft_EM_Mod_0601.mat;

figure;
patch('Faces', tri, 'Vertices', ver, 'FaceColor', [0.8, 0.8, 0.8], 'EdgeColor', 'none');
xlabel('X'); ylabel('Y'); zlabel('Z');
axis equal;
lighting gouraud;
camlight;


num_samples = 1000; % Adjust as needed
sample_indices = randperm(size(ver, 1), num_samples);
sample_points = ver(sample_indices, :);

[V, C] = voronoin(sample_points);

plot3(V(:,1), V(:,2), V(:,3), 'b.');

hold on;
for i = 1:length(C)
    vert_indices = C{i}; % indices of vertices forming a Voronoi region
    
    for j = 1:length(vert_indices)
        for k = j+1:length(vert_indices)
            % Check if the vertices are neither Inf nor NaN
          
                plot3(V([vert_indices(j), vert_indices(k)], 1), ...
                      V([vert_indices(j), vert_indices(k)], 2), ...
                      V([vert_indices(j), vert_indices(k)], 3), 'b-');
            
        end
    end
end
