clear;
clc;
map.XYMAX = 10; %��������Ҫ��һ����ͼ�ĳ��Ϳ�
map.start = [1,1];%�������
repeat = 0;%�ظ��������
FillPlot(map.start,'g');%�����Ⱦ��
obstacle = GetBoundary(map);%�õ��߽�����
obstacle = [obstacle;4,1;4,2;4,3;5,1;6,1;7,1;7,2;7,3;7,5];%�˴��ֶ�����ϰ�������
pathlog = map.start;%·����ʷ
PlotGrid(map);
hold on;

%�����ϰ���
FillPlot(obstacle,'k');

rollback = false;%Ϊfalse����һ��ʼ������
[~,sum_of_repeat] = UReturn(map.start,pathlog,map,obstacle,rollback,repeat);%��ʼ������
disp('�ظ���Ϊ');
disp(sum_of_repeat/((map.XYMAX+2)^2-length(obstacle(:,1))));