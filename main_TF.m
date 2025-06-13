% function main_TF(file,tempo_index, function_index, fmin,fmax,fstep,tol)
% function main_TF( fmin,fmax,fstep,tol)
function main_TF()
arguments
    % file string
    % tempo_index double
    % function_index double
    % fmin double
    % fmax double
    % fstep double
    % tol double
    % aux double
end
%
%
% Programa para cálculo da resposta em frequência de um sistema utilizando
% sua resposta no tempo ao impulso unitário e a transformada de Fourier.
%
% Chamada do programa para selecionar o diretório e o arquivo de dados
% de entrada.
%
% Programa para selecionar o diretório e o arquivo de dados de entrada.
%
%
% Fornecimento pelo usuário do nome da variável que armazena os instantes
% de tempo.
%
fid = fopen("Dados.txt");
fmin = str2double(fgetl(fid));
fmax = str2double(fgetl(fid));
fstep = str2double(fgetl(fid));
tol = str2double(fgetl(fid));
% npontos = real(str2double(fgetl(fid)));
% t = zeros(1,npontos) ;
% ft = zeros(1,npontos) ;
% a = zeros(1,2) ;
% for i = 1:npontos
%     line = fgetl(fid);
%     ind = 0;
%     indi = 1;
%     indf = 0;
%     for j = 1:length(line)
%         if (line(j)==';')
%             ind = ind + 1;
%             indf = j;
%             a(1,ind) = real(str2double(line(indi:indf-1)));
%             indi = indf + 1;
%         end
%     end
%     t(i) = a(1);
%     ft(i) = a(2);
% end
fclose(fid);
% 
% 
% fprintf('0 - %e - %e - %e - %e - \n',fmin,fmax,fstep,tol);
%
% fid = fopen("Entrada.txt");
% while(eod(fid))
% 
% end
% S = coder.load('Entrada.MAT','t','ft');
% t = S.t;
% ft = S.ft;
S = matfile('Entrada.MAT');
t = S.t;
ft = S.ft;
%
tamanho = (real(fmax)-real(fmin)+1)/real(fstep);
f = zeros(1,tamanho) ;
w = zeros(1,tamanho) ;
% f = zeros(1,3001);
%
ind = 0;
for i=fmin:fstep:fmax
    ind = ind + 1;
    f(ind) = i;
    if i == 0
        f(1) = 1e-3;
    end
    w(ind) = 2*pi*f(ind);
end
%
%
% Início da contagem do tempo de execução do programa.
%
tic
%
% Cálculo do passo de integração.
%
Dt=t(2)-t(1);
%
% Determinação do número de instantes de tempo ou de valores da resposta
% ao impulso.
%
n_t=length(t);
%
% Determinação do número de intervalos de tempo.
%
n_Dt=n_t-1;
%
% Definição da faixa da frequência de interesse.
%
% f=fmin:fstep:fmax;
%
% Definição dos pontos de frequência para cálculo da transformada de
% Fourier sem truncamento do tempo.
%
I=zeros(1,5);
%
f1=logspace(0,log10(f(end)),5);
%
for i=1:5
    Df=abs(f-f1(i));
    [~,j]=min(Df);
    I(i)=j;
end
%
f1=f(I);
w1=2*pi*f1;
%
% Chamada da rotina para cálculo da transformada de Fourier (F1) sem 
% trumcamento do tempo nos pontos de frequência f1.
%
F1=Fourier(Dt,n_Dt,t,ft,w1);
%
% Chamada da rotina para cálculo da transformada de Fourier (F) em todos
% os pontos de frequência com trumcamento do tempo, quando:
%
%        erro = max(abs( ( F(I)-F1 )./F1 ) )*100 <= tol;
%
% onde tol é a tolerância escolhida em %.
%
% tol=0.1;
%
[F,erro]=Fourier(Dt,n_Dt,t,ft,w,F1,I,tol);
%
% Fim da contagem do tempo de execução do programa.
%
time = toc;
%
fout = fopen("Saidas.txt","w+");
fprintf(fout,"%lf\n",erro);
fprintf(fout,"%lf\n",time);
%
for i=1:length(f)
    fprintf(fout,"%lf;%lf;%lf \n",f(i),real(F(i)), imag(F(i)));
end
fclose(fout);
%