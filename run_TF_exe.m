fclose all
% clear all
clc
% Chamada do programa para selecionar o diretório e o arquivo de dados
% de entrada.
%
Abertura
%
% Montagem de estrura com os dados de entrada.
%
S=load(file);
% S=load(nome);
%
% Determinação dos nomes das variáveis contidas em S.
%
nomes=fields(S);
%
% Transformação do vetor de células nomes para vetor de "strings".
%
nomes=string(nomes);
%
% Determinação do comprimento do vetor de "strings" nomes.
%
n_nomes=length(nomes);
%
% Criação de um vetor com as posições existentes em nomes.
%
k=1:n_nomes;
%
% Fornecimento pelo usuário do nome da variável que armazena os instantes
% de tempo.
%
fprintf('\n')
fprintf(' Nomes das variáveis armazenadas no arquivo "mat"\n');
fprintf('\n')
%
for i=1:n_nomes
    fprintf('\n')
    fprintf('%20s %s %s %d %s',nomes(i),' --> ','(',i,')');
    fprintf('\n')
end
%
while( 1 )
    fprintf('\n')
    ind_1=input(' Variável tempo: ','s');
    ind_1=str2num(ind_1);
    I=find(ind_1==k);
    if(~isempty(I))
        break
    else
       fprintf('\n')
       fprintf('%s %d',' Responda de 1 a', n_nomes');
       fprintf('\n')
   end
end
%
% Fornecimento pelo usuário do nome da variável que armazena os valores
% da resposta ao impulso.
%
while( 1 )
    fprintf('\n')
    ind_2=input(' Variável resposta ao impulso: ','s');
    ind_2=str2num(ind_2);
    I=find(ind_2==k);
    if(~isempty(I))
        break
    else
       fprintf('\n')
       fprintf('%s %d',' Responda de 1 a', n_nomes');
       fprintf('\n')
   end
end
%
% 
%
fprintf('\n')
fprintf(' Digite a frequência mínima\n');
fprintf('\n')
val=input(' frequência mínima: ','s');
fmin=str2num(val);
fprintf('\n')
fprintf(' Digite a frequência máxima\n');
fprintf('\n')
val=input(' frequência máxima: ','s');
fmax=str2num(val);
fprintf('\n')
% fprintf(' Digite o passo da frequência\n');
fprintf('\n')
val=input(' passo: ','s');
fstep=str2num(val);
fprintf('\n')
fprintf(' Digite a tolerância\n');
fprintf('\n')
val=input(' toledância: ','s');
tol=str2num(val);
%
fprintf('\n')
%
% Criação dos vetores de instantes de tempo (t) e de resposta
% ao impulso (ft)
%
t=S.(nomes{ind_1});
ft=S.(nomes{ind_2});
%
% save Entrada.MAT t ft;
delete Saidas.txt;
delete Dados.txt;
fid = fopen('Dados.txt','w+');
fprintf(fid, '%e\n',fmin);
fprintf(fid, '%e\n',fmax);
fprintf(fid, '%e\n',fstep);
fprintf(fid, '%e\n',tol);
fprintf(fid, '%e\n',length(ft));
for i = 1:length(ft)
    fprintf(fid, '%.15e;%.15e;\n',t(i),ft(i));
end
fclose(fid);
%
F     = [];
freq  = [];
freal = [];
fimag = [];
%
tic
uiopen([path '\main_TF.exe'],1);
%
% fout = fopen("Saidas.txt","r+");
% aguarda finalização do executavel
while(~isfile('Saidas.txt'))
    a = 1 + 2;
end
toc
%
fout = fopen('Saidas.txt','r+');
ind = 0;
erro = str2double(fgetl(fout));
tempo = str2double(fgetl(fout));
while ~feof(fid)
    ind = ind + 1;
    line = fgetl(fout);
    C = strsplit(line,';');
    freq(ind)=str2double(C{1});
    freal(ind)=str2double(C{2});
    fimag(ind)=str2double(C{3});
end
%
fprintf('Erro de %f %% e tempo de simulacao de %f %%',erro,tempo);
%
F = freal + 1i*fimag;
%
figure(1)
hold on
plot(freq,abs(F))
%
% Constante para conversão de radianos para graus.
%
r2d=180/pi;
%
figure(2)
hold on
plot(freq,angle(F)*r2d)