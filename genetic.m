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
%������Ⱥ������Ӧ�ȣ��Բ�ͬ���Ż�Ŀ�꣬�˴���Ҫ��д
%pop_size: ��Ⱥ��С
%chromo_size: Ⱦɫ�峤��


function fitness(pop_size, chromo_size)
global fitness_value;
global pop;
global G;
for i=1:pop_size
    fitness_value(i) = 0.;
end

for i=1:pop_size
    for j=1:chromo_size
        if pop(i,j) == 1
            fitness_value(i) = fitness_value(i)+2^(j-1);
        end
    end
    fitness_value(i) = -1+fitness_value(i)*(3.-(-1.))/(2^chromo_size-1);
    fitness_value(i) = -(fitness_value(i)-1).^2+4;
end

clear i;
clear j;
end
%�Ը��尴��Ӧ�ȴ�С�������򣬲��ұ�����Ѹ���
%pop_size: ��Ⱥ��С
%chromo_size: Ⱦɫ�峤��


function rank(pop_size, chromo_size)
global fitness_value;
global fitness_table;
global fitness_avg;
global best_fitness;
global best_individual;
global best_generation;
global pop;
global G;

for i=1:pop_size
    fitness_table(i) = 0.;
end

min = 1;
temp = 1;
temp1(chromo_size)=0;
for i=1:pop_size
    min = i;
    for j = i+1:pop_size
        if fitness_value(j)<fitness_value(min);
            min = j;
        end
    end
    if min~=i
        temp = fitness_value(i);
        fitness_value(i) = fitness_value(min);
        fitness_value(min) = temp;
        for k = 1:chromo_size
            temp1(k) = pop(i,k);
            pop(i,k) = pop(min,k);
            pop(min,k) = temp1(k);
        end
    end
    
end

for i=1:pop_size
    if i==1
        fitness_table(i) = fitness_table(i) + fitness_value(i);
    else
        fitness_table(i) = fitness_table(i-1) + fitness_value(i);
    end
end
fitness_avg(G) = fitness_table(pop_size)/pop_size;


if fitness_value(pop_size) > best_fitness
    best_fitness = fitness_value(pop_size);
    best_generation = G;
    for j=1:chromo_size
        best_individual(j) = pop(pop_size,j);
    end
end


clear i;
clear j;
clear k;
clear min;
clear temp;
clear temp1;
end

%���̶�ѡ�����
%pop_size: ��Ⱥ��С
%chromo_size: Ⱦɫ�峤��
%cross_rate: �Ƿ�Ӣѡ��



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
    
    for j=1:chromo_size
        pop_new(i,j)=pop(idx,j);
    end
end
if elitism
    p = pop_size-1;
else
    p = pop_size;
end
for i=1:p
    for j=1:chromo_size
        pop(i,j) = pop_new(i,j);
    end
end

clear i;
clear j;
clear pop_new;
clear first;
clear last;
clear idx;
clear mid;
end

%���㽻�����
%pop_size: ��Ⱥ��С
%chromo_size: Ⱦɫ�峤��
%cross_rate: �������



function crossover(pop_size, chromo_size, cross_rate)
global pop;
for i=1:2:pop_size
    if(rand < cross_rate)
        cross_pos = round(rand * chromo_size);
        if or (cross_pos == 0, cross_pos == 1)
            continue;
        end
        for j=cross_pos:chromo_size
            temp = pop(i,j);
            pop(i,j) = pop(i+1,j);
            pop(i+1,j) = temp;
        end
    end
end


clear i;
clear j;
clear temp;
clear cross_pos;
end

%����������
%pop_size: ��Ⱥ��С
%chromo_size: Ⱦɫ�峤��
%cross_rate: �������
function mutation(pop_size, chromo_size, mutate_rate)
global pop;

for i=1:pop_size
    if rand < mutate_rate
        mutate_pos = round(rand*chromo_size);
        if mutate_pos == 0
            continue;
        end
        pop(i,mutate_pos) = 1 - pop(i, mutate_pos);
    end
end

clear i;
clear mutate_pos;
end



%��ӡ�㷨��������
%generation_size: ��������
function plotGA(generation_size)
global fitness_avg;
x = 1:1:generation_size;
y = fitness_avg;
plot(x,y)
end

%�Ŵ��㷨������
%pop_size: ������Ⱥ��С
%chromo_size: ����Ⱦɫ�峤��
%generation_size: �����������
%cross_rate: ���뽻�����
%cross_rate: ����������
%elitism: �����Ƿ�Ӣѡ��
%m: �����Ѹ���
%n: ��������Ӧ��
%p: �����Ѹ�����ִ�
%q: �����Ѹ����Ա���ֵ

function [m,n,p,q] = GeneticAlgorithm(pop_size, chromo_size, generation_size, cross_rate, mutate_rate, elitism)

global G ; %��ǰ��
global fitness_value;%��ǰ����Ӧ�Ⱦ���
global best_fitness;%���������Ӧֵ
global fitness_avg;%����ƽ����Ӧֵ����
global best_individual;%������Ѹ���
global best_generation;%��Ѹ�����ִ�



fitness_avg = zeros(generation_size,1);

disp "hhee"

fitness_value(pop_size) = 0.;
best_fitness = 0.;
best_generation = 0;
initilize(pop_size, chromo_size);%��ʼ��
for G=1:generation_size
    fitness(pop_size, chromo_size);  %������Ӧ��
    rank(pop_size, chromo_size);  %�Ը��尴��Ӧ�ȴ�С��������
    selection(pop_size, chromo_size, elitism);%ѡ�����
    crossover(pop_size, chromo_size, cross_rate);%�������
    mutation(pop_size, chromo_size, mutate_rate);%�������
end
plotGA(generation_size);%��ӡ�㷨��������
m = best_individual;%�����Ѹ���
n = best_fitness;%��������Ӧ��
p = best_generation;%�����Ѹ�����ִ�
%�����Ѹ������ֵ���Բ�ͬ���Ż�Ŀ�꣬�˴���Ҫ��д
q = 0.;
for j=1:chromo_size
    if best_individual(j) == 1
        q = q+2^(j-1);
    end
end
q = -1+q*(3.-(-1.))/(2^chromo_size-1);

clear i;
clear j;
end