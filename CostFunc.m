function [ chromosome ] = CostFunc( chromosome, Xtr, Ytr, inputNum, outputNum, bitNum )

	network = ChromosomeToNetwork(chromosome, inputNum, outputNum, bitNum);
    fullyConnection = (7^2^(size(network.Layer,2))) * inputNum * outputNum;
	network = Get_NetworkCost(network, Xtr, Ytr);
	chromosome.MSE = network.MSE;
	noc = NumberOfConnections( network.Layer );
	pnoc = (100/fullyConnection) * noc;
	chromosome.Cost = 0.5*(pnoc + network.MSE);
    
end

function [ noc ] = NumberOfConnections( layer )
    layerNo = size(layer,2);
    noc = 0;
    for i=1:layerNo - 1
        l1 = layer(i);
        l2 = layer(i+1);
        noc = noc + l1*l2;
    end
end
