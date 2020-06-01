function [up,to] = move_up(pathlog,position)
up = [pathlog;position+[0,1]];
to = position+[0,1];

end

