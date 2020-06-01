function [right,to] = move_right(pathlog,position)
right = [pathlog;position+[1,0]];
to = position+[1,0];

end

