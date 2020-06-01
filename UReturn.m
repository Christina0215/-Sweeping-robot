function [pathlog,sum_of_repeat] = UReturn(Start,pathlog,map,obstacle,rollback,sum_of_repeat)
lastpath = pathlog;%开始本次弓形走前的路程历史
thispath = [];%本次弓形走的路程
position = Start;%当前坐标
toward = [];%A星计算出的目标点
while 1
    if ~up_passable(position,pathlog,obstacle) && ~down_passable(position,pathlog,obstacle) && right_passable(position,pathlog,obstacle)
        %如果只能向右走就向右走
        [pathlog,position] = move_right(pathlog,position);
    end
    while rollback == false%没掉头时
        while up_passable(position,pathlog,obstacle)%如果能向上走就一直向上走
            [pathlog,position] = move_up(pathlog,position);
        end
        if right_passable(position,pathlog,obstacle)%碰到障碍物后向右
            [pathlog,position] = move_right(pathlog,position);
            rollback = true;%同时掉头
        else%如果进入死角
            x = length(pathlog(:,1));
            y = x - length(lastpath(:,1));
            thispath = pathlog((x-y+1):x,:);%计算本次路程
            plot(thispath(:,1),thispath(:,2),'-g','LineWidth',5);hold on;%绘制本次弓形路线
            if length(pathlog) == (map.XYMAX+2)^2-length(unique(obstacle,'rows'))%如果已经走完了就return
                return
            end
            [toward,pathlog,repeat] = FindNearest(position,obstacle,map,pathlog);%找出距当前位置最近的未清扫区域
            sum_of_repeat = sum_of_repeat + repeat;%总的重复区域数量
            if up_passable(toward,pathlog,obstacle)%判断该点附近情况决定是否掉头
                [pathlog,sum_of_repeat] = UReturn(toward,pathlog,map,obstacle,false,sum_of_repeat);
                if length(pathlog) == (map.XYMAX+2)^2-length(unique(obstacle,'rows'))%迭代结束后的判断
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
    while rollback == true%同上
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

    
    