function [ child ] = Adapt_Network(child, parent,inputNum,outputNum,bitNum)
    
    child_layer = GetLayer(child,inputNum,outputNum,bitNum);
    parent_layer = GetLayer(parent,inputNum,outputNum,bitNum);

    layerNum = size(child_layer,2);
    c_w_num = 0;
    p_w_num = 0;
    
    for i=1:layerNum - 1
        c_w_num = c_w_num + child_layer(i) * child_layer(i+1);
        p_w_num = p_w_num + parent_layer(i)* parent_layer(i+1);
    end
    
    if(c_w_num > p_w_num)
       child = Add_Weight(child,1,p_w_num,c_w_num-p_w_num);
    else if(c_w_num < p_w_num)
          child = Delete_Weight(child,p_w_num,p_w_num-c_w_num);
         end
    end
    
end