%��ʼ����Ⱥ
%pop_size: ��Ⱥ��С
%chromo_size: Ⱦɫ�峤��

function grupp = initilize(pop_size, chromo_size)
for i=1:pop_size
    for j=1:chromo_size
        grupp.pop(i,j) = round(rand);
    end
end
grupp.best_fitness =0;
end