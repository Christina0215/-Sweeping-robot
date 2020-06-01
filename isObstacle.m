function flag = isObstacle( m,obstacle )

%判断节点m是否为障碍点，如果是就返为1，不是就返回0
for io=1:length(obstacle(:,1))
    if isequal(obstacle(io,:),m(1:2))
        flag=true;
        return;
    end
end
flag=false;


end