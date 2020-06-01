function right = right_passable(position,pathlog,obstacle)
next = position + [1,0];
if ~ismember(next,pathlog,'rows') && ~ismember(next,obstacle,'rows')
    right = true;
else
    right = false;
end
end
