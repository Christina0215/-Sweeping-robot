function [isopenFlag,Id] = isopen( node,open )

%判断节点是否在open列表中，在open中，isopenFlag = 1,不在open中，isopenFlag = 0 .并反回索引号

isopenFlag = 0;
Id = 0;

%如果open列表为空，则不在open列表中
if  isempty(open)
    isopenFlag = 0;

else %open列表不为空时
    for i = 1:length( open(:,1) )
       if isequal(  node(1:2) , open(i,1:2)  )  %在Openlist中
            isopenFlag = 1;
            Id = i;
            return;
       end 
    end
end

end