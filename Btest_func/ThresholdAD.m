function threshold = ThresholdAD(array)
% Adjusts the threshold based on the an approximated diameter of the aorta
% based on the detected points. 

    Xmax = max(array(:,1));
    Xmin = min(array(:,1));
    Ymax = max(array(:,2));
    Ymin = min(array(:,2));
    Xdist = Xmax-Xmin;
    Ydist = Ymax-Ymin;
    diameter = (Xdist+Ydist)/2;
    if diameter < 400
        threshold = 90;
    else
        threshold = 115;
        
    end
    

end