function [path,long,pathlog,repeat]=AStar(obstacle,map,draw,pathlog)

%{
Astar算法思路
1.将起始点放在Openlist中
2.重复以下过程：
  
  首先判断是否到达目标点，或无路径
    >>如果终点已加入到Openlist中，则已找到路径（此时起始点就是目标点，无需再找）
    >>Openlist为空，无路径

  a.按照Openlist中的第三列（代价函数F）进行排序，查找F值最小的节点
  b.把这个F值最小的节点移到Closelist中作为 当前节点
  c.对当前节点周围的8个相邻节点：
    >>如果它不可达，忽略它
    >>如果它在Closelist中，忽略它
    >>如果它不在Openlist中，加放Openlist，并把当前节点设置为它的父节点，记录该节点的F值
    >>如果它已经在Openlist中，检查经当前节点到达那里是否更好(用G或F值判断)，
         >如果更好，则将当前节点设置为其父节点，并更新F,G值；如果不好，则不作处理

3.保存路径
%}



%用于存储路径
path=[];
%OpenList
open=[];
%用于储存长度
long=0;
%CloseList
close=[];
%findFlag用于判断while循环是否结束
findFlag=false;

%================1.将起始点放在Openlist中======================
%open变量每一行  [节点坐标，代价值F=G+H,代价值G,父节点坐标]
open =[map.start(1), map.start(2) , 0+h(map.start,map.goal) , 0 , map.start(1) , map.start(2)];

%更新状态--下一步的八个点
next=MotionModel();

%=======================2.重复以下过程==============================

while ~findFlag
    


%--------------------首先判断是否达到目标点，或无路径-----
    if isempty(open(:,1))
        return;
    end
    
    %判断目标点是否出现在open列表中
    [isopenFlag,Id]=isopen(map.goal,open);
    if isopenFlag
        close = [open(Id,:);close];
        findFlag=true;
        break;
    end


    %------------------a.按照Openlist中的第三列（代价函数F）进行排序，查找F值最小的节点
    [Y,I] = sort(open(:,3)); %对OpenList中第三列排序
    open=open(I,:);%open中第一行节点是F值最小的
    
    %------------------b.将F值最小的节点(即open中第一行节点)，放到close第一行(close是不断积压的)，作为当前节点
    close = [open(1,:);close];
    current = open(1,:);
    open(1,:)=[];%因为已经从open中移除了，所以第一列需要为空
    
    %--------------------c.对当前节点周围的8个相邻节点，算法的主体：------------------------
    for in=1:length(next(:,1))
        
        %获得相邻节点的坐标,代价值F先等于0,代价值G先等于0  ,后面两个值是其父节点的坐标值，暂定为零(因为暂时还无法判断其父节点坐标是多少)
        m=[current(1,1)+next(in,1) , current(1,2)+next(in,2) , 0 , 0 , 0 ,0]; 
        m(4)=current(1,4)+next(in,3); % m(4)  相邻节点G值
        m(3)=m(4)+h(m(1:2),map.goal);% m(3)  相邻节点F值
        
        %>>如果它不可达，忽略它，处理下一个相邻节点  (注意，obstacle这个数组中是包括边界的)
        if isObstacle(m,obstacle)
            continue;
        end
        
        %flag == 1：相邻节点  在Closelist中  targetInd = close中行号
        %flag == 2：相邻节点不在Openlist中   targetInd = []
        %flag == 3：相邻节点  在Openlist中   targetInd = open中行号
        [flag,targetInd]=FindList(m,open,close);
        
        %>>如果它在Closelist中，忽略此相邻节点
        if flag==1 
            continue;
        %>>如果它不在Openlist中，加入Openlist,并把当前节点设置为它的父节点
        elseif flag==2 
            m(5:6)=[current(1,1),current(1,2)];%将当前节点作为其父节点
            open = [open;m];%将此相邻节点加放openlist中
        %>>剩下的情况就是它在Openlist中，检查由当前节点到相邻节点是否更好，如果更好则将当前节点设置为其父节点，并更新F,G值；否则不操作    
        else
            %由当前节点到达相邻节点更好(targetInd是此相邻节点在open中的行号 此行的第3列是代价函数F值)
            if m(3) < open(targetInd,3)
                %更好，则将此相邻节点的父节点设置为当前节点，否则不作处理
                m(5:6)=[current(1,1),current(1,2)];%将当前节点作为其父节点
                open(targetInd,:) = m;%将此相邻节点在Openlist中的数据更新
            end
        end
        
        %下面的end是判断八个相邻节点的for循环的end
    end
    
    %=====绘制======
    PlotGrid(map);
    hold on;
    pause(0.01);
    %绘制节点close
end

%追溯路径
path=GetPath(close,map.start);
plot(path(:,1),path(:,2),'-c','LineWidth',5);
if draw
    path(length(path(:,1)),:) = [];
    repeatblock = intersect(path,pathlog,'rows');%重复区域
    repeat = length(repeatblock(:,1));
    FillPlot(repeatblock,'r');
end   
if nargin == 4
    pathlog = unique([pathlog;path],'rows','stable');
else
long = length(path);
end
