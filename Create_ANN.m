function [ Network ] = Create_ANN( Network )
    layerNum = size(Network.Layer,2);
    if(isempty(Network.W))
        Network.W = cell(layerNum, layerNum);
    end
    if(isempty(Network.b))
        Network.b = -1 + 2*rand(1,layerNum - 1);
    end
    for i=1:layerNum - 1
        sl = Network.Layer(i);
        dl = Network.Layer(i+1);
        if(isempty(Network.W{i,i+1}))
            w = -1 + 2*rand(sl,dl);
            Network.W{i,i+1} = w;
        end
    end
end