function [c1, c2] = CrossoverOnW_B( p1, p2 )
    c1 = p1;
    c2 = p2;
    size_p1 = size(p1.W_B,2);
    size_p2 = size(p2.W_B,2);
    minSize = min(size_p1, size_p2);

    c = randi([1 minSize]);
    c1.W_B(1:minSize) = [p1.W_B(1:c),p2.W_B(c+1:minSize)];
    c2.W_B(1:minSize) = [p2.W_B(1:c),p1.W_B(c+1:minSize)];
end

