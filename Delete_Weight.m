function [ cr ] = Delete_Weight( cr, endPoint, numberOfW )
    r = randperm(endPoint);
    deleteIndex = r(1:numberOfW);
    cr.W_B(deleteIndex) = [];
end

