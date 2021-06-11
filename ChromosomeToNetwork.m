function [ Network ] = ChromosomeToNetwork( chromosome, inputNum, outputNum, bn )
    Network.Layer = [];
    Network.W = {};
    Network.b = [];
    Network.MSE = [];
    Network.RMSE = [];
    
    bitNum = size(chromosome.Structure,2);
    for i = 3:bn:bitNum-(bn-1)
        d1 = chromosome.Structure(i+1:i+bn);
        Network.Layer = [Network.Layer, bin2dec(num2str(d1))];
    end
    
    Network.Layer = [inputNum, Network.Layer, outputNum];
    W = chromosome.W_B;
    
    layerNum = size(Network.Layer,2);
    Network.W = cell(layerNum, layerNum);

    for i=1:layerNum - 1
        sl = Network.Layer(i);
        dl = Network.Layer(i+1);
        if(isempty(Network.W{i,i+1}))
            wTemp = W(1:sl*dl);
            Network.W{i,i+1} = reshape(wTemp,sl,dl);
        end
    end
    Network.b = W(size(W,2)-(layerNum-1)+1:size(W,2));
end

