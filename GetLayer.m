function [ lr ] = GetLayer( cr, inputNum, outputNum, bn )
    bitNum = size(cr.Structure,2);
    lr = [];
    for i = 4:bn:bitNum-2
        d1 = cr.Structure(i:i+bn-1);
        lr = [lr, bin2dec(num2str(d1))];
    end
    lr = [inputNum, lr, outputNum];
end

