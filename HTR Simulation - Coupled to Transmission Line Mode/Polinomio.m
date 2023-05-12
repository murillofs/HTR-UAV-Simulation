function [Posicao, Velocidade, Aceleracao] = Polinomio(ti,tf,P0,Pf,V0,Vf,dx,T_final)

% ti = Tempo Inicial
% tf = Tempo Final
% P0 = Posição Inicial
% Pf = Posição Final
% V0 = Velocidade Inicial
% V0 = Velocidade Final
% dx = Elemento diferencial do tempo 
% T_final = Tempo Final 

% Constroi um polinomio de terceira ordem do tempo inicial(ti) ao tempo
% final (tf) da posição incial (P0) a posição final (Pf), com a velocidade 
% inicial (V0)e velocidade final (Vf). Extendendo o ultimo valor ate o
% tempo final (T_final)


 A = [ ti^3    ti^2   ti    1;
       tf^3    tf^2   tf    1;
       3*ti^2  2*ti    1    0;
       3*tf^2  2*tf    1    0];
 
 B = [P0; Pf ; V0 ; Vf];
 
 X = A\B;
 %% Constroi o sinal de Posicao, Velocidade e Aceleração
 zero = 0 : dx : ti;
 y    = 0 : dx : tf;                %Ti-------------------------Tf%
 y2   = 0 : dx : T_final;   %------------------tempo total----------------%
 
 for i =1:length(y2)
     if(i<=length(y))
         Posicao(i)    = X(1)*y(i)^3 + X(2)*y(i)^2 + X(3)*y(i) + X(4);
         Velocidade(i) = 3*X(1)*y(i)^2 + 2*X(2)*y(i) + X(3);
         Aceleracao(i) = 6*X(1)*y(i) + 2 * X(2);
     else
         Posicao(i)    = Posicao(length(y));
         Velocidade(i) = 0;%Velocidade(length(y));
         Aceleracao(i) = 0;%Aceleracao(length(y));
     end
     if(i<length(zero))
         Posicao(i)    = P0;
         Velocidade(i) = 0;
         Aceleracao(i) = 0; 
     end     
 end
% %  
%  plot(y2,Posicao)
%  hold on
%  plot(y2,Velocidade,'r')
%  plot(y2,Aceleracao,'g')
%  hold off