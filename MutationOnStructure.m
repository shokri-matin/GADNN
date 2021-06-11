function [ c ] = MutationOnStructure( c,inputNum,outputNum,bitNum )
    pc = c;
    sizec = size(c.Structure,2);
    burst = randi([1 round(sizec/2)]);
    r = randi([3 sizec],1,burst);
    c.Structure(r) = 1-c.Structure(r);
    c = Reform_Layers(c, bitNum);
    c = Adapt_Network(c,pc,inputNum,outputNum,bitNum);
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
