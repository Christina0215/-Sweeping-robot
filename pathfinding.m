clear;
clc;
map.XYMAX = 10; %代表我们要画一个地图的长和宽
map.start = [1,1];%起点坐标
repeat = 0;%重复区域个数
FillPlot(map.start,'g');%将起点染绿
obstacle = GetBoundary(map);%得到边界数据
obstacle = [obstacle;4,1;4,2;4,3;5,1;6,1;7,1;7,2;7,3;7,5];%此处手动添加障碍物坐标
pathlog = map.start;%路程历史
PlotGrid(map);
hold on;

%画出障碍点
FillPlot(obstacle,'k');

rollback = false;%为false代表一开始向上走
[~,sum_of_repeat] = UReturn(map.start,pathlog,map,obstacle,rollback,repeat);%开始弓形走
disp('重复率为');
disp(sum_of_repeat/((map.XYMAX+2)^2-length(obstacle(:,1))));