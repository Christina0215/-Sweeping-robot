function hcost = h( m,goal )

%����������������ֵ ����������������㷨
hcost =10* abs(  m(1)-goal(1)  )+10*abs(  m(2)-goal(2)  );

end