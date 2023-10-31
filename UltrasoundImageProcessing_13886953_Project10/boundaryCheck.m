function center = boundaryCheck(criticalpts,array,center,boundary)
% Checks the perimeter of the center coordinates. In the case the center is
% within an enclosed space this function scans the area and will shift to a
% more open space. See image 448.jpg in the phantom dataset for a visual.

% critical pts = points that are too close to the center
% array = array of detected points
% center = center coordinates 
% boundary = sets the boundaries to see the density of points and to shift
% to area with less density 

    temparray = array(criticalpts,:);
    valid = false;
    % if the boundary is too small and there are too many points, this will
    % expand the boundary to check where there is open space
    expand = 0; 
    while(valid == false)
        upperBound = find(temparray(:,2)>center(2)+boundary+expand);
        lowerBound = find(temparray(:,2)<center(2)-boundary-expand);
        rightBound = find(temparray(:,1)>center(1)+boundary+expand);
        leftBound = find(temparray(:,1)<center(1)-boundary-expand);
        if isempty(upperBound) == true
            valid = true;
            n = 1;
        elseif isempty(lowerBound) == true
            valid = true;
            n = 2;
        elseif  isempty(rightBound) == true
            valid = true;
            n = 3;
        elseif isempty(leftBound) == true
            valid = true;
            n = 4;
        else 
            valid = false;
        end
        expand = expand + 2;
    end
    
    switch n
        case 1
            disp('Shift Upwards')
            center(2) = center(2)+boundary+expand;
        case 2
            disp('Shift Downwards')
            center(2) = center(2)-boundary-expand;

        case 3
            disp('Shift Right')
            center(1) = center(1)+boundary+expand;

        case 4
            disp('Shift Left')
            center(1) = center(1)-boundary-expand;
    end

end
