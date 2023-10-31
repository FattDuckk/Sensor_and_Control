function [distance,criticalpts] = ptCheck(center,array,threshold)
% Finds all the distances from each point to the center. The results are
% then filtered to only include detected points that are too close to the
% center.

% center = center coordinates
% threshold = minimum safe distance from the outer ring
% array = detected points
% distance = distance from detected points to the center
% criticalpts = the points that are below the threshold that will readjust
% the center

    criticalpts = [];
    distance = zeros(length(array),1);
    for i = 1:length(array)
        % distance formula 
        distance(i) = sqrt((center(1)-array(i,1))^2+(center(2)-array(i,2))^2);
        % Plots the points to the center for visual aid
        example(1,:) = center;
        example(2,:) = array(i,:);
        plot(example(:,1),example(:,2));
    end
    
    % Finding the indexes of the points that are too close to the center.
    criticalpts = find(distance<=threshold);

end