function [o] = DisplayResult(Network, Xtest)

    layerNum = size(Network.Layer,2);
    for i=1:layerNum
        for j=1:layerNum
            if(~isempty(Network.W{i,j}))
               o = tansig(Xtest * Network.W{i,j});
               Xtest = o;
            end
        end
    end
    
end

