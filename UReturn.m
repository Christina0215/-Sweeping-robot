function [pathlog,sum_of_repeat] = UReturn(Start,pathlog,map,obstacle,rollback,sum_of_repeat)
lastpath = pathlog;%��ʼ���ι�����ǰ��·����ʷ
thispath = [];%���ι����ߵ�·��
position = Start;%��ǰ����
toward = [];%A�Ǽ������Ŀ���
while 1
    if ~up_passable(position,pathlog,obstacle) && ~down_passable(position,pathlog,obstacle) && right_passable(position,pathlog,obstacle)
        %���ֻ�������߾�������
        [pathlog,position] = move_right(pathlog,position);
    end
    while rollback == false%û��ͷʱ
        while up_passable(position,pathlog,obstacle)%����������߾�һֱ������
            [pathlog,position] = move_up(pathlog,position);
        end
        if right_passable(position,pathlog,obstacle)%�����ϰ��������
            [pathlog,position] = move_right(pathlog,position);
            rollback = true;%ͬʱ��ͷ
        else%�����������
            x = length(pathlog(:,1));
            y = x - length(lastpath(:,1));
            thispath = pathlog((x-y+1):x,:);%���㱾��·��
            plot(thispath(:,1),thispath(:,2),'-g','LineWidth',5);hold on;%���Ʊ��ι���·��
            if length(pathlog) == (map.XYMAX+2)^2-length(unique(obstacle,'rows'))%����Ѿ������˾�return
                return
            end
            [toward,pathlog,repeat] = FindNearest(position,obstacle,map,pathlog);%�ҳ��൱ǰλ�������δ��ɨ����
            sum_of_repeat = sum_of_repeat + repeat;%�ܵ��ظ���������
            if up_passable(toward,pathlog,obstacle)%�жϸõ㸽����������Ƿ��ͷ
                [pathlog,sum_of_repeat] = UReturn(toward,pathlog,map,obstacle,false,sum_of_repeat);
                if length(pathlog) == (map.XYMAX+2)^2-length(unique(obstacle,'rows'))%������������ж�
                return
                end
            else
                [pathlog,sum_of_repeat] = UReturn(toward,pathlog,map,obstacle,false,sum_of_repeat);
                if length(pathlog) == (map.XYMAX+2)^2-length(unique(obstacle,'rows'))
                return
                end
            end
        end
    end
    while rollback == true%ͬ��
        while down_passable(position,pathlog,obstacle)
            [pathlog,position] = move_down(pathlog,position);
        end
        if right_passable(position,pathlog,obstacle)
            [pathlog,position] = move_right(pathlog,position);
            rollback = false;
        else 
            x = length(pathlog(:,1));
            y = x - length(lastpath(:,1));
            thispath = pathlog((x-y+1):x,:);
            plot(thispath(:,1),thispath(:,2),'-g','LineWidth',5);hold on;
            if length(pathlog) == (map.XYMAX+2)^2-length(unique(obstacle,'rows'))
                return
            end
            [toward,pathlog,repeat] = FindNearest(position,obstacle,map,pathlog);
            sum_of_repeat = sum_of_repeat + repeat;
            if up_passable(toward,pathlog,obstacle)
                [pathlog,sum_of_repeat] = UReturn(toward,pathlog,map,obstacle,false,sum_of_repeat);
                if length(pathlog) == (map.XYMAX+2)^2-length(unique(obstacle,'rows'))
                return
                end
            else
                [pathlog,sum_of_repeat] = UReturn(toward,pathlog,map,obstacle,false,sum_of_repeat);
                if length(pathlog) == (map.XYMAX+2)^2-length(unique(obstacle,'rows'))
                return
                end
            end
        end
    end
end

    
    