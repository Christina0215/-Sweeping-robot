function [isopenFlag,Id] = isopen( node,open )

%�жϽڵ��Ƿ���open�б��У���open�У�isopenFlag = 1,����open�У�isopenFlag = 0 .������������

isopenFlag = 0;
Id = 0;

%���open�б�Ϊ�գ�����open�б���
if  isempty(open)
    isopenFlag = 0;

else %open�б�Ϊ��ʱ
    for i = 1:length( open(:,1) )
       if isequal(  node(1:2) , open(i,1:2)  )  %��Openlist��
            isopenFlag = 1;
            Id = i;
            return;
       end 
    end
end

end