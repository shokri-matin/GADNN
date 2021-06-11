function [pop costs] = SortPopulation( pop )
    costs = [pop.Cost]; 
    [costs sortOrder] = sort(costs);
    pop = pop(sortOrder);
end

