function [interior] = fillVoxel(FV)

voxel = polygon2voxel(FV, [200 200 200], 'auto');

% Fill the interior
a_filled = imfill(voxel, 'holes');

% Subtract the exterior to get only the filled interior
interior = a_filled - voxel;

end