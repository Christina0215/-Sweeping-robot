function up = up_passable(position,pathlog,obstacle)
next = position + [0,1];
if ~ismember(next,pathlog,'rows') && ~ismember(next,obstacle,'rows')
    up = true;
else
    up = false;
end
end
