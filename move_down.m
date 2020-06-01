function [down,to] = move_down(pathlog,position)
down = [pathlog;position+[0,-1]];
to = position+[0,-1];

end

