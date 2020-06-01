function [point,long] = FindSecond(position,obstacle,map,pathlog)
%Ѱ���Ե�ǰλ��Ϊԭ��ʱ�ڶ������о�����̵ĵ�
flag = 0;%����������һ��ѭ��
black = [obstacle;pathlog];
draw = false;
for i1 = 0:position(1)-1
    for i2 = position(2):map.XYMAX
        if ~ismember([position(1)-i1,i2],black,'rows')
            flag = 1;
            map.start = position;
            map.goal = [position(1)-i1,i2];
            point = [position(1)-i1,i2];
            [~,long] = AStar(obstacle,map,draw);
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


