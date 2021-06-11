function [ Network ] = Get_NetworkCost( Network, Xtr, Ytr)

    layerNum = size(Network.Layer,2);
    for i=1:layerNum
        for j=1:layerNum
            if(~isempty(Network.W{i,j}))
               o = tansig(Xtr * Network.W{i,j});
               Xtr = o;
            end
        end
    end
    Network.MSE = mse(o - Ytr);
    Network.RMSE = sqrt(Network.MSE);
end

