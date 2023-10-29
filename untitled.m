clear all
close all

% 1. Visualizing the Contours

folder_path = 'Students/Data2_Soft_pullback_1/Contours/'; % Replace with the path to your contour folder
file_list = dir(fullfile(folder_path, '*.txt'));


% Plotting contours
figure;
hold on;
axis equal

%%
for i = 1
    hold on
    filePath = fullfile('Students/Data2_Soft_pullback_1/Contours/', sprintf('%d.txt', i));
    data=table2array(readtable(filePath));
    plot(data(:,1), data(:,2));
end
% hold off;
%%
% 2. Computing a simple centerline using the contours

% For this example, we'll compute the centroid of each contour
% and treat it as a point on the centerline.

centerline_points = zeros(length(file_list), 2); % [x, y]

for i = 1:length(file_list)
    data = load(fullfile(folder_path, file_list(i).name));
    centerline_points(i, :) = mean(data, 1); % computing the centroid
end

% Plotting centerline along with contours
figure;
hold on;
for i = 1:length(file_list)
    data = load(fullfile(folder_path, file_list(i).name));
    plot(data(:,1), data(:,2));
end
plot(centerline_points(:,1), centerline_points(:,2), 'r-', 'LineWidth', 2); % centerline in red
hold off;
