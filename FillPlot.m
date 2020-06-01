function FillPlot(coord,color)


%coord为给出的点的坐标，为 n by 2 的向量，第一列为点的x坐标，第二列为点的y坐标 
%我们画出以这些点为中心，边长为1的填充正方形 color为颜色  如color = 'k'时，表示黑色



for i = 1:length(coord(:,1))
   
    x = coord(i,1);
    y = coord(i,2);
    
    X = [x-0.5,x+0.5,x+0.5,x-0.5];
    Y = [y-0.5,y-0.5,y+0.5,y+0.5];
    
    fill(X,Y,color);
    
    hold on;
end

axis equal;


end