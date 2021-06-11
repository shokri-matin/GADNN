function [ cr ] = Add_Weight( cr, startPoint, endPoint , numberOfW )
    w1 = cr.W_B(startPoint:endPoint);
    w2 = -1 + 2*rand(1,numberOfW);
    w3 = cr.W_B(endPoint+1:end);
    
    cr.W_B = [w1 w2 w3];
end