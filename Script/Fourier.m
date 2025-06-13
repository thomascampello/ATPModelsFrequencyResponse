%   
% Rotina para cálculo da transformada de Fourier. 
%
function [F,erro]=Fourier(Dt,n_Dt,t,ft,w,F1,I,tol)
%
% Definição das variáveis de entrada.
%
% Dt --> Passo de integração.
%
% n_Dt --> Número de intervalos de tempo.
%
% t --> Tempo.
%
% ft --> Resposta ao impulso.
%
% w --> Frequência (rad/s).
%
% F1 --> Transformada de Fourier sem truncamento do tempo nos pontos de
%        frequência w(I).
%
% I --> Índice dos pontos de frequência para cálculo da transformada de
%       Fourier sem trumcamento do tempo.
%
% Definição das variáveis auxiliares.
%
a=exp(-1j.*w.*t(1));
b=1./w;
c=b.^2;
d=1j*Dt*w;
e=exp(-d);
f=e-1;
g=d.*e;
h=c.*(f+g);
k=b.*f;
%
% Inicialização da transformada de Fourier (F) de ft.
%
F=zeros(size(a))+zeros(size(a))*1i;
erro = 0;
%
% Loop para cálculo das contribuições DF_i de cada intervalo de tempo 
% para a transformada F.
%
for i=1:n_Dt
    %
    % Mostra a evolução do cálculo de F.
    %
    % if( mod(i,10001)==0 )
    %     fprintf('Instante de tempo de integração: %e\n',t(i))
    %     fprintf('\n')
    % end
    %
    % Seleção dos valores da função nos limites do intevalo "i".
    %
    ft_1=ft(i);
    ft_2=ft(i+1);
    %
    % Cálculo da tangente de teta em cada intervalo.
    %
    tgt=(ft_2-ft_1)/Dt;
    %
    % Cálculo da contribuição DF_i de cada intervalo para F.
    %
    DF_i=a.*(tgt.*h+1j*ft_1*k);
    %
    a=a.*e;
    %
    % Contribuição de DF_i para F.
    %
    F=F+DF_i;
    %
    % Cálculo do erro de truncamento da integração no tempo.
    %
    if(nargin>5)
        erro=max(abs( ( F(I)-F1 )./F1 ) )*100;
        %
        if(erro<=tol)
            i
            t(i)
            erro
            break
        end
    end
    %
end
%
end

