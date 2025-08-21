function [branch_x, branch_y, branch_z] = pruneOffBranch(adj_matrix, x, y, z, start_node, end_node)
    n = size(adj_matrix, 1);
    visited = false(1, n);
    predecessor = zeros(1, n);
    
    % BFS to determine predecessors
    queue = start_node;
    visited(start_node) = true;
    found = false;
    while ~isempty(queue)
        current_node = queue(1);
        queue(1) = [];
        
        neighbors = find(adj_matrix(current_node, :));
        for ii = 1:length(neighbors)
            neighbor = neighbors(ii);
            if ~visited(neighbor)
                visited(neighbor) = true;
                predecessor(neighbor) = current_node;
                queue(end+1) = neighbor;  % enqueue
                
                if neighbor == end_node
                    found = true;
                    break;
                end
            end
        end
        if found
            break;
        end
    end
    
    % If there's no path from start_node to end_node
    if ~found
        branch_x = [];
        branch_y = [];
        branch_z = [];
        return;
    end
    
    % Reconstruct the main branch using predecessors
    main_branch = [];
    node = end_node;
    while node ~= start_node
        main_branch = [node, main_branch];
        node = predecessor(node);
    end
    main_branch = [start_node, main_branch];
    
    % Extract coordinates of the nodes in the main branch
    branch_x = x(main_branch);
    branch_y = y(main_branch);
    branch_z = z(main_branch);
end