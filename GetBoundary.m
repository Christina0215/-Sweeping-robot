function boundary=GetBoundary(map)
%获得地图的边界的坐标
boundary=[];
for i1=0:(map.XYMAX+1)
    boundary=[boundary;[0 i1]];
end
for i2=1:(map.XYMAX+1)
    boundary=[boundary;[i2 0]];
end
for i3=1:(map.XYMAX+1)
    boundary=[boundary;[map.XYMAX+1 i3]];
end
for i4=1:(map.XYMAX)
    boundary=[boundary;[i4 map.XYMAX+1]];
end
end