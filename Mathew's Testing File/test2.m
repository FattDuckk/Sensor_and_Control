% Create a new figure
figure;

% Create a 3D axis
axis equal;
grid on;
xlabel('X');
ylabel('Y');
zlabel('Z');
hold on;


% Define the position
position = [1.62, -162.32, -160.93];

% Plot the position using a red 'o' marker
plot3(position(1), position(2), position(3), 'ro');

% Assuming you have the Aerospace Toolbox
q = quaternion(0.7694, -0.3945, 0.3493, 0.361);
rotMatrix = rotmat(q, 'frame');

scale = 10;  % adjust for desired axis length

% Define the basic unit vectors for X, Y, and Z
unitVectors = eye(3);

% Rotate and scale these unit vectors
rotatedVectors = scale * (rotMatrix * unitVectors')';

% Plot each axis
quiver3(position(1), position(2), position(3), rotatedVectors(1, 1), rotatedVectors(1, 2), rotatedVectors(1, 3), 'r', 'AutoScale', 'off'); % X-axis in red
quiver3(position(1), position(2), position(3), rotatedVectors(2, 1), rotatedVectors(2, 2), rotatedVectors(2, 3), 'g', 'AutoScale', 'off'); % Y-axis in green
quiver3(position(1), position(2), position(3), rotatedVectors(3, 1), rotatedVectors(3, 2), rotatedVectors(3, 3), 'b', 'AutoScale', 'off'); % Z-axis in blue
