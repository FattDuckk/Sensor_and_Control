%%
clear 
clf

% Uncomment below to save images after being processed
% for j=1:2002
%     clearvars -except j
%     clf
%     A = imread(sprintf('%d.jpg',j));
%------------------------------------------------------
%% Read and Convert Image to BW    
    A = imread('446.jpg');
    A = im2bw(A);
    imshow(A)
    
    % Filters out inner ring and irrelevant white sections
    A(1:50,:) = 0;
    A(360:430,350:414) = 0;
    
    % Determines the center coordinates based on image size
    sz = size(A);
    center = [sz(1)/2,sz(2)/2];

    shift = 20; % distance to move the center away from the points
    boundary = 67/2-10; % Sets boundaries for Sort Function
    
    imshow(A)
    axis on

%% Detects the vertices to gives points of the outer ring (vessel wall)
    B = detectHarrisFeatures(A,"FilterSize",65);
    [features,valid_corners] = extractFeatures(A,B);
    hold on
    scatter(center(1),center(2)) % Plots the center
    plot(valid_corners) % Plots the points detected
    locpts = valid_corners.Location;
    threshold = ThresholdAD(locpts); % Sets the threshold based on aortic diameter

%% Loop to make sure the center (catheter) is at a safe distance away from all the detected points
    Checker = true;
    initial = true;
    while(Checker == true)
        % Will be used more often to keep checking the location of the
        % center relative to the detected points
        [distance,criticalpts] = ptCheck(center,locpts,threshold);
        if isempty(criticalpts) == false && initial == true
            % only needed once to move the center out of the enclosed space
            center = boundaryCheck(criticalpts,locpts,center,boundary);
            [distance,criticalpts] = ptCheck(center,locpts,threshold);
        end
        % This section will be looped to move the center accordingly until
        % all points are above the distance threshold
        if isempty(criticalpts) == false 
            [distance,criticalpts] = ptCheck(center,locpts,threshold);
            center = Sort(distance,locpts,center,shift);
        % If the center is already in a safe coordinate, there is no need
        % to make adjustments
        elseif isempty(criticalpts == true)
            Checker = false;
        end

        initial = false; % turns off boundaryChecker
        plotCenter = scatter(center(1),center(2),'white'); % Plots the new center for visual aid

    end

    disp('Done!')
% Uncomment below to save images after being processed
%     saveas(gcf,sprintf("%d.jpg",j)) 
%     end
%----------------------------------------------------
    