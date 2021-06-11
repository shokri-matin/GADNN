function [ c ] = MutationOnW_B( c )
    sizec = size(c.W_B,2);
    burst = randi([1 round(sizec/2)]);
    r = randi([1 sizec],1,burst);
    c.W_B(r) = -1 + 2 * rand(1,burst);
end