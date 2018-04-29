

%���̶�ѡ�����
%pop_size: ��Ⱥ��С
%chromo_size: Ⱦɫ�峤��
%elitism: �Ƿ�Ӣѡ��



function selection(pop_size, chromo_size, elitism)
global pop;
global fitness_table;

for i=1:pop_size
    r = rand * fitness_table(pop_size);
    first = 1;
    last = pop_size;
    mid = round((last+first)/2);
    idx = -1;
    while (first <= last) && (idx == -1)
        if r > fitness_table(mid)
            first = mid;
        elseif r < fitness_table(mid)
            last = mid;
        else
            idx = mid;
            break;
        end
        mid = round((last+first)/2);
        if (last - first) == 1
            idx = last;
            break;
        end
    end
    pop_new(i,:)=pop(idx,:);
end
if elitism
    pop(1:end-1,:) = pop_new(1:end-1,:);
else
    pop = pop_new;
end
    
end
