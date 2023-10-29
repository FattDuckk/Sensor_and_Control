clear
close all
% Define the vertices of the cube
vertices = [0 0 0;
            1 0 0;
            1 1 0;
            0 1 0;
            0 0 1;
            1 0 1;
            1 1 1;
            0 1 1];

% Define the faces of the cube
faces = [1 2 3 4;
         5 6 7 8;
         1 2 6 5;
         2 3 7 6;
         3 4 8 7;
         4 1 5 8];

% Colors for the two halves (let's choose blue and red)
blue = [0 0 1];
red = [1 0 0];

% Assign a color to each vertex based on its x-coordinate
colors = zeros(8, 3);  % Preallocate
for i = 1:8
    if vertices(i, 1) <= 0.5
        colors(i, :) = blue;
%     else
%         colors(i, :) = red;
    end
end

% Create the 3D cube with colored faces
figure;
patch('Vertices', vertices, 'Faces', faces, 'FaceVertexCData', colors, 'FaceColor', 'interp');

% Add some axis settings for better visualization
axis equal;
xlabel('X'); ylabel('Y'); zlabel('Z');
grid on;
title('3D Cube with Different Colored Halves');
view(3);  % 3D view
