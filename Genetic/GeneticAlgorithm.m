% Genetic Algorithm

function outputData = GeneticAlgorithm(para,img_stack)

global G ; %��ǰ��
global fitness_value;%��ǰ����Ӧ�Ⱦ���
global best_fitness;%���������Ӧֵ
global fitness_avg;%����ƽ����Ӧֵ����
global best_individual;%������Ѹ���
global best_generation;%��Ѹ�����ִ�
global img_stack_after

pop_size = para.genetic.pop_size;
chromo_size = 13;
generation_size = para.genetic.generation_size;
cross_rate = para.genetic.cross_rate;
mutate_rate = para.genetic.mutate_rate;
elitism = para.genetic.elitism;

img_stack_after = img_stack;
fitness_avg = zeros(generation_size,1);
fitness_value(pop_size) = 0.;
best_fitness = 0;
best_generation = 0;
initilize(pop_size, chromo_size);%��ʼ��
for G = 1:generation_size
    fprintf(['Generation: ',num2str(G)])
    fitness(pop_size,para);  %������Ӧ��
    rank(pop_size, chromo_size);  %�Ը��尴��Ӧ�ȴ�С��������
    selection(pop_size, chromo_size, elitism);%ѡ�����
    crossover(pop_size, chromo_size, cross_rate);%�������
    mutation(pop_size, chromo_size, mutate_rate);%�������
end
plotGA(generation_size);%��ӡ�㷨��������
m = best_individual;%�����Ѹ���
outputData.para.Kth = (2^4*m(1)+2^3*m(2)+2^2*m(3)+2^1*m(4)+2^0*m(5))/10+0.1;
outputData.para.Elementsize = 2^3*m(6)+2^2*m(7)+2^1*m(8)+2^0*m(9)+1;
outputData.para.MinVolume = (2^3*m(10)+2^2*m(11)+2^1*m(12)+2^0*m(13))*20+20;
outputData.bestDistance = 1/best_fitness;%��������Ӧ��
outputData.bestGeneration = best_generation;%�����Ѹ�����ִ�
[outputData.merkmal.porositaet,outputData.merkmal.endKnoten,outputData.merkmal.stegLaenge,outputData.merkmal.objectAnzahl]= callPrototyp(outputData.para.Kth,outputData.para.Elementsize,outputData.para.MinVolume,para);
clear global
end