clc;
clear;
close all; 
%%
load Mesh_Soft_EM_Mod_0601.mat;

a=ver;
FV.vertices = ver;

FV.faces = tri;

figure(1);
hold on
% patch(FV,'facecolor',[1 0 0],'facealpha',0.8,'edgecolor','none');
aorta=patch(FV,'facecolor',[1 0 0],'facealpha',0.6,'edgecolor','none');
view(3)
camlight
axis equal;


%%
[V, C] = voronoin(ver);
% figure(2)
% plot3(V(:,1), V(:,2), V(:,3), 'r*');

%%
% 
% f=tri;
% vert=ver;
% % % Extract the isosurface for v = 2.5 (example surface)
% % [f, vert] = isosurface(x, y, z, v, 2.5);
% 
% % Define a slicing plane (ax + by + cz + d = 0)
% a = 0; b = 0; c = 1; d = -1;
% 
% % Intersect the isosurface with the slicing plane
% intersectPoints = intersectPlaneSurf(a, b, c, d, vert, f);
% 
% % Visualize the 3D model and the slice
% figure;
% patch('Faces', f, 'Vertices', vert, 'FaceColor', 'c', 'EdgeColor', 'none');
% hold on;
% fill3(intersectPoints(:,1), intersectPoints(:,2), intersectPoints(:,3), 'r');
% alpha(0.5);
% axis equal;
% xlabel('X'); ylabel('Y'); zlabel('Z');
% title('Aorta Model with Slice');
% view(3);
% 
% %% Sectioning
% close all
% vertotal=size(ver)
% 
% verSize=vertotal(1,1)
% 
% blue = [1 1 1];
% black = [0 0 0];
% 
% colour=zeros(verSize,3);
% 
% for i=1:verSize
%     if i<100000
%         colour(i, :)=blue;
%     
%     end
% end
% 
% figure(1)
% patch(FV, 'FaceVertexCData', colour,'FaceColor', 'interp')
% view(3)
% camlight