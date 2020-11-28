classdef data
    
    properties
        data_va
        
    end
        
    methods(Static)
        function [AX,AY,AZ,GX,GY,GZ] = get_data(walk_type,data_set)
            data_vals = load(data_set); 
            
            if walk_type == "Ascent"
                startcolumn = 1;
                
            elseif walk_type == "Descent"
                startcolumn = 2;
                
            elseif walk_type == "Norm"
                startcolumn = 3;
                
            else
                error('Passed in invalid walk type')
            end
         
            AX = data_vals(:, startcolumn);
            AY = data_vals(:, startcolumn+3);
            AZ = data_vals(:, startcolumn+6);
            GX = data_vals(:, startcolumn+9);
            GY = data_vals(:, startcolumn+12);
            GZ = data_vals(:, startcolumn+15);
         
        end
        
        function time = get_time(data_set)
            data_vals = load(data_set);
            time = data_vals(:, 19);
        end
    end
end