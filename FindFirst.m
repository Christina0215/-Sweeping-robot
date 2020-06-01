function [point,long] = FindFirst(position,obstacle,map,pathlog)
%寻找以当前位置为原点时第一象限中距离最短的点
flag = 0;%用于跳出第一层循环
draw = false;%由于是试探距离所以不绘制A星路线
black = [obstacle;pathlog];%不能走的区域
for i1 = position(1):map.XYMAX
    for i2 = position(2):map.XYMAX
        if ~ismember([i1,i2],black,'rows')%如果该区域可以走
            flag = 1;
            map.start = position;
            map.goal = [i1,i2];
            point = [i1,i2];
            [~,long] = AStar(obstacle,map,draw);%用A星计算距离
            break
        end
    end
    if flag
        break
    end
    point = [0,0];
    long = inf;
end
end


