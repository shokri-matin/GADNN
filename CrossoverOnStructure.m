function [ c1, c2 ] = CrossoverOnStructure( p1, p2, inputNum, outputNum, bitNum )
    c1 = p1;
    c2 = p2;
    size_p1 = size(p1.Structure,2);
    size_p2 = size(p2.Structure,2);
    minSize = min(size_p1, size_p2);

    c = randi([4 minSize]);
    c1.Structure(4:minSize) = [p1.Structure(4:c),p2.Structure(c+1:minSize)];
    c2.Structure(4:minSize) = [p2.Structure(4:c),p1.Structure(c+1:minSize)];
    
    % Add or delete the ran dom cells in W&B based on new structure
    c1 = Reform_Layers(c1, bitNum);
    c2 = Reform_Layers(c2, bitNum);
    c1 = Adapt_Network(c1,p1,inputNum,outputNum,bitNum);
    c2 = Adapt_Network(c2,p2,inputNum,outputNum,bitNum);
end

function [c] = Reform_Layers(c, bitNum)
    sizec = size(c.Structure,2);
    for i=3:sizec - bitNum
        if(c.Structure(i+1:i+bitNum) == zeros(1,bitNum))
           r = randi(bitNum);
           c.Structure(i+r) = 1;
        end
    end
end