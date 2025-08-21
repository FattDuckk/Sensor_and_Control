function [spline_x,spline_y,spline_z] = smoothSkel(pruned_skel,detail)
            x = pruned_skel(:, 1);
            y = pruned_skel(:, 2);
            z = pruned_skel(:, 3);
            
            % Parameterize the curve by its cumulative chordal arclength
            t = [0; cumsum(sqrt(diff(x).^2 + diff(y).^2 + diff(z).^2))];
            t = t / t(end); % normalize to [0, 1]
            
            % Fit cubic B-splines using least-squares approximation
            num_knots = 20;  % Adjust this number for desired smoothness
            sp_x = spap2(num_knots,4,t,x);
            sp_y = spap2(num_knots,4,t,y);
            sp_z = spap2(num_knots,4,t,z);
            
            % Evaluate B-spline at a set of points for plotting
            tt = linspace(0, 1, detail);
            spline_x = fnval(sp_x, tt);
            spline_y = fnval(sp_y, tt);
            spline_z = fnval(sp_z, tt);
end