%   
% Rotina para c�lculo da transformada de Fourier. 
%
function [F,erro]=Fourier(Dt,n_Dt,t,ft,w,F1,I,tol)
%
% Defini��o das vari�veis de entrada.
%
% Dt --> Passo de integra��o.
%
% n_Dt --> N�mero de intervalos de tempo.
%
% t --> Tempo.
%
% ft --> Resposta ao impulso.
%
% w --> Frequ�ncia (rad/s).
%
% F1 --> Transformada de Fourier sem truncamento do tempo nos pontos de
%        frequ�ncia w(I).
%
% I --> �ndice dos pontos de frequ�ncia para c�lculo da transformada de
%       Fourier sem trumcamento do tempo.
%
% Defini��o das vari�veis auxiliares.
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
% Inicializa��o da transformada de Fourier (F) de ft.
%
F=zeros(size(a))+zeros(size(a))*1i;
erro = 0;
%
% Loop para c�lculo das contribui��es DF_i de cada intervalo de tempo 
% para a transformada F.
%
for i=1:n_Dt
    %
    % Mostra a evolu��o do c�lculo de F.
    %
    % if( mod(i,10001)==0 )
    %     fprintf('Instante de tempo de integra��o: %e\n',t(i))
    %     fprintf('\n')
    % end
    %
    % Sele��o dos valores da fun��o nos limites do intevalo "i".
    %
    ft_1=ft(i);
    ft_2=ft(i+1);
    %
    % C�lculo da tangente de teta em cada intervalo.
    %
    tgt=(ft_2-ft_1)/Dt;
    %
    % C�lculo da contribui��o DF_i de cada intervalo para F.
    %
    DF_i=a.*(tgt.*h+1j*ft_1*k);
    %
    a=a.*e;
    %
    % Contribui��o de DF_i para F.
    %
    F=F+DF_i;
    %
    % C�lculo do erro de truncamento da integra��o no tempo.
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

