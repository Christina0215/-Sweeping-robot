function hcost = h( m,goal )

%计算启发函数代价值 ，这里采用曼哈顿算法
hcost =10* abs(  m(1)-goal(1)  )+10*abs(  m(2)-goal(2)  );

end