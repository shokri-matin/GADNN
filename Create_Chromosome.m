function [ chromosome ] = Create_Chromosome( network, bitNum )

    chromosome.Structure = [];
    chromosome.W_B = [];
    chromosome.Cost = [];
    chromosome.MSE = [];
    
    numberOfLayer = size(network.Layer,2);
    
    for i=1:numberOfLayer
        for j=1:numberOfLayer
             if(~isempty(network.W{i,j}))
                w = reshape(network.W{i,j},1,size(network.W{i,j},1)*size(network.W{i,j},2));
                chromosome.W_B = [chromosome.W_B,w];
             end
        end
    end
    chromosome.W_B = [chromosome.W_B,network.b];
    
    for i=2:numberOfLayer-1
        chromosome.Structure = [chromosome.Structure, dec2bin(network.Layer(i),bitNum)];
    end
    chromosome.Structure = [dec2bin(size(network.Layer,2)-2,3),chromosome.Structure];
    chromosome.Structure = double(chromosome.Structure)-48;
end

