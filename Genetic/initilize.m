%��ʼ����Ⱥ
%pop_size: ��Ⱥ��С
%chromo_size: Ⱦɫ�峤��

function initilize(pop_size, chromo_size)
global pop;
for i=1:pop_size
    for j=1:chromo_size
        pop(i,j) = round(rand);
    end
end
clear i;
clear j;
end