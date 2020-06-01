function down = down_passable(position,pathlog,obstacle)
next = position + [0,-1];
if ~ismember(next,pathlog,'rows') && ~ismember(next,obstacle,'rows')
    down = true;
else
    down = false;
end
end
