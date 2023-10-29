clc;
clear;
close all;

%%
load Mesh_Soft_EM_Mod_0601.mat;

FV.vertices = ver;
FV.faces = tri;

figure(1);

patch(FV,'facecolor',[1 0 0],'facealpha',0.3,'edgecolor','none');
% patch(FV,'facecolor',[1 0 0],'facealpha',0.3,'edgecolor','none');
view(3)
camlight
axis equal;

% centreline=mean(ver)
hold on

%%
hold on
axis equal
load EM_InData.mat

Data=table2array(Data);

scatter3(Data(:,1),Data(:,2),Data(:,3),'o','blue');

% end

load EM_OutData.mat

Data2=table2array(Data2);

% scatter3(Data2(:,1),Data2(:,2),Data2(:,3));

for i=1:20:length(Data)

    position = Data(i, 1:3);

    q=quaternion(Data(i,4:7));
    
    rotMatrix = 3*rotmat(q, 'frame');

    quiver3(position(1), position(2), position(3), rotMatrix(1, 1), rotMatrix(1, 2), rotMatrix(1, 3), 'r', 'AutoScale', 'off'); % X-axis
    quiver3(position(1), position(2), position(3), rotMatrix(2, 1), rotMatrix(2, 2), rotMatrix(2, 3), 'g', 'AutoScale', 'off'); % Y-axis
    quiver3(position(1), position(2), position(3), rotMatrix(3, 1), rotMatrix(3, 2), rotMatrix(3, 3), 'b', 'AutoScale', 'off'); % Z-axis

end
%%


 %%
% % Assuming you want the top half along the z-axis
% z_threshold = median(ver(:, 3));
% 
% % Select vertices above the threshold
% selected_vertices = find(ver(:, 3) > z_threshold);
% 
% % Find triangles that use only the selected vertices
% selected_triangles = all(ismember(tri, selected_vertices), 2);
% 
% % Subset the data
% ver_selected = ver(selected_vertices, :);
% tri_selected = tri(selected_triangles, :);
% 
% % Remap the triangle vertex indices to the new subset
% [~, remapped_indices] = ismember(tri_selected, selected_vertices);
% tri_selected = remapped_indices;
% 
% % Now plot using patch
% figure;
% patch('Vertices', ver_selected, 'Faces', tri_selected, 'FaceColor', [0.8, 0.8, 0.8]);
% 
% figure;
% patch('Vertices', ver, 'Faces', tri, 'FaceColor', [0.8, 0.8, 0.8]);
% axis tight; 
% zlim([z_threshold, max(ver(:, 3))]); % Adjust the z-limits
