function [point,long] = FindFirst(position,obstacle,map,pathlog)
%Ѱ���Ե�ǰλ��Ϊԭ��ʱ��һ�����о�����̵ĵ�
flag = 0;%����������һ��ѭ��
draw = false;%��������̽�������Բ�����A��·��
black = [obstacle;pathlog];%�����ߵ�����
for i1 = position(1):map.XYMAX
    for i2 = position(2):map.XYMAX
        if ~ismember([i1,i2],black,'rows')%��������������
            flag = 1;
            map.start = position;
            map.goal = [i1,i2];
            point = [i1,i2];
            [~,long] = AStar(obstacle,map,draw);%��A�Ǽ������
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


