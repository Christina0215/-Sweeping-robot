function [path,long,pathlog,repeat]=AStar(obstacle,map,draw,pathlog)

%{
Astar�㷨˼·
1.����ʼ�����Openlist��
2.�ظ����¹��̣�
  
  �����ж��Ƿ񵽴�Ŀ��㣬����·��
    >>����յ��Ѽ��뵽Openlist�У������ҵ�·������ʱ��ʼ�����Ŀ��㣬�������ң�
    >>OpenlistΪ�գ���·��

  a.����Openlist�еĵ����У����ۺ���F���������򣬲���Fֵ��С�Ľڵ�
  b.�����Fֵ��С�Ľڵ��Ƶ�Closelist����Ϊ ��ǰ�ڵ�
  c.�Ե�ǰ�ڵ���Χ��8�����ڽڵ㣺
    >>��������ɴ������
    >>�������Closelist�У�������
    >>���������Openlist�У��ӷ�Openlist�����ѵ�ǰ�ڵ�����Ϊ���ĸ��ڵ㣬��¼�ýڵ��Fֵ
    >>������Ѿ���Openlist�У���龭��ǰ�ڵ㵽�������Ƿ����(��G��Fֵ�ж�)��
         >������ã��򽫵�ǰ�ڵ�����Ϊ�丸�ڵ㣬������F,Gֵ��������ã���������

3.����·��
%}



%���ڴ洢·��
path=[];
%OpenList
open=[];
%���ڴ��泤��
long=0;
%CloseList
close=[];
%findFlag�����ж�whileѭ���Ƿ����
findFlag=false;

%================1.����ʼ�����Openlist��======================
%open����ÿһ��  [�ڵ����꣬����ֵF=G+H,����ֵG,���ڵ�����]
open =[map.start(1), map.start(2) , 0+h(map.start,map.goal) , 0 , map.start(1) , map.start(2)];

%����״̬--��һ���İ˸���
next=MotionModel();

%=======================2.�ظ����¹���==============================

while ~findFlag
    


%--------------------�����ж��Ƿ�ﵽĿ��㣬����·��-----
    if isempty(open(:,1))
        return;
    end
    
    %�ж�Ŀ����Ƿ������open�б���
    [isopenFlag,Id]=isopen(map.goal,open);
    if isopenFlag
        close = [open(Id,:);close];
        findFlag=true;
        break;
    end


    %------------------a.����Openlist�еĵ����У����ۺ���F���������򣬲���Fֵ��С�Ľڵ�
    [Y,I] = sort(open(:,3)); %��OpenList�е���������
    open=open(I,:);%open�е�һ�нڵ���Fֵ��С��
    
    %------------------b.��Fֵ��С�Ľڵ�(��open�е�һ�нڵ�)���ŵ�close��һ��(close�ǲ��ϻ�ѹ��)����Ϊ��ǰ�ڵ�
    close = [open(1,:);close];
    current = open(1,:);
    open(1,:)=[];%��Ϊ�Ѿ���open���Ƴ��ˣ����Ե�һ����ҪΪ��
    
    %--------------------c.�Ե�ǰ�ڵ���Χ��8�����ڽڵ㣬�㷨�����壺------------------------
    for in=1:length(next(:,1))
        
        %������ڽڵ������,����ֵF�ȵ���0,����ֵG�ȵ���0  ,��������ֵ���丸�ڵ������ֵ���ݶ�Ϊ��(��Ϊ��ʱ���޷��ж��丸�ڵ������Ƕ���)
        m=[current(1,1)+next(in,1) , current(1,2)+next(in,2) , 0 , 0 , 0 ,0]; 
        m(4)=current(1,4)+next(in,3); % m(4)  ���ڽڵ�Gֵ
        m(3)=m(4)+h(m(1:2),map.goal);% m(3)  ���ڽڵ�Fֵ
        
        %>>��������ɴ��������������һ�����ڽڵ�  (ע�⣬obstacle����������ǰ����߽��)
        if isObstacle(m,obstacle)
            continue;
        end
        
        %flag == 1�����ڽڵ�  ��Closelist��  targetInd = close���к�
        %flag == 2�����ڽڵ㲻��Openlist��   targetInd = []
        %flag == 3�����ڽڵ�  ��Openlist��   targetInd = open���к�
        [flag,targetInd]=FindList(m,open,close);
        
        %>>�������Closelist�У����Դ����ڽڵ�
        if flag==1 
            continue;
        %>>���������Openlist�У�����Openlist,���ѵ�ǰ�ڵ�����Ϊ���ĸ��ڵ�
        elseif flag==2 
            m(5:6)=[current(1,1),current(1,2)];%����ǰ�ڵ���Ϊ�丸�ڵ�
            open = [open;m];%�������ڽڵ�ӷ�openlist��
        %>>ʣ�µ������������Openlist�У�����ɵ�ǰ�ڵ㵽���ڽڵ��Ƿ���ã���������򽫵�ǰ�ڵ�����Ϊ�丸�ڵ㣬������F,Gֵ�����򲻲���    
        else
            %�ɵ�ǰ�ڵ㵽�����ڽڵ����(targetInd�Ǵ����ڽڵ���open�е��к� ���еĵ�3���Ǵ��ۺ���Fֵ)
            if m(3) < open(targetInd,3)
                %���ã��򽫴����ڽڵ�ĸ��ڵ�����Ϊ��ǰ�ڵ㣬����������
                m(5:6)=[current(1,1),current(1,2)];%����ǰ�ڵ���Ϊ�丸�ڵ�
                open(targetInd,:) = m;%�������ڽڵ���Openlist�е����ݸ���
            end
        end
        
        %�����end���жϰ˸����ڽڵ��forѭ����end
    end
    
    %=====����======
    PlotGrid(map);
    hold on;
    pause(0.01);
    %���ƽڵ�close
end

%׷��·��
path=GetPath(close,map.start);
plot(path(:,1),path(:,2),'-c','LineWidth',5);
if draw
    path(length(path(:,1)),:) = [];
    repeatblock = intersect(path,pathlog,'rows');%�ظ�����
    repeat = length(repeatblock(:,1));
    FillPlot(repeatblock,'r');
end   
if nargin == 4
    pathlog = unique([pathlog;path],'rows','stable');
else
long = length(path);
end
