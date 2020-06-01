function [point,long] = FindThird(position,obstacle,map,pathlog)
%Ѱ���Ե�ǰλ��Ϊԭ��ʱ���������о�����̵ĵ�
flag = 0;%����������һ��ѭ��
black = [obstacle;pathlog];
draw = false;
for i1 = 0:position(1)-1
    for i2 = 0:position(2)-1
        if ~ismember([position(1)-i1,position(2)-i2],black,'rows')
            flag = 1;
            map.start = position;
            map.goal = [position(1)-i1,position(2)-i2];
            point = [position(1)-i1,position(2)-i2];
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


