function center = Sort(distance,array,center,shift)
% This functions finds the closest point to the center and determines the
% coordinates of the location it will need to move away from the closest
% point. Based on a hypothetical straight line made between the closest
% point and the center point to shift in the opposite direction

% Distance = distance of each point from the center
% Array = points detected
% center = center coordinates 
% shift = distance to shift the away from the closest point to redefine the
% center
    closestDist = min(distance);
    closestDistpt = find(closestDist==distance);
    closestpt = array(closestDistpt,:);
    m = (center(2)-closestpt(2))/(center(1)-closestpt(1)); %gradient of two points to find the angle 
    theta = atan(m);
    % Using trigonometry to find the location of the new center
    xdist = shift*cos(theta);
    ydist = shift*sin(theta);
    % Determines the direction tthe x and y distances to shift the center
    % coordinates
    if center(2) > closestpt(2)
        center(2) = center(2)-ydist;
    elseif center(2) < closestpt(2)
        center(2) = center(2) + ydist;
    else 
        disp('Error')
    end

    if center(1) > closestpt(1)
        center(1) = center(1)+xdist;
    elseif center(1) < closestpt(1)
        center(1) = center(1)-xdist;
    else
        disp('Error')
    end
end