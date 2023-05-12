function SetPointsCreation

% Global variable(s)
global Sim SP Time2;

%% Catenary SP
h_torre = 50;
SP.x_Cat   = -Sim.L/2:(Sim.L/(length(Time2)-1)):Sim.L/2;
SP.y_Cat   = (exp(Sim.a*SP.x_Cat) + exp(-Sim.a*SP.x_Cat) - 2)/(2*Sim.a);
t1 = max(SP.y_Cat);
SP.h_tower = h_torre - t1;
SP.y_Cat   = SP.h_tower + (exp(Sim.a*SP.x_Cat) + exp(-Sim.a*SP.x_Cat) - 2)/(2*Sim.a);
SP.theta   = atan(sinh(Sim.a*SP.x_Cat)); 

%% Position SP
% North Position
Pn = Polinomio(0,2.5,-Sim.L/2,150,0,0,Sim.Ts*Sim.Freq,Sim.Tfinal-Sim.Ts*Sim.Freq);

SP.Position  = Pn;

%% Angular SP
% Roll SP -> rad
RollSP1  = Polinomio(0,5,0,20,0,0,Sim.Ts*Sim.Freq,Sim.Tfinal-Sim.Ts*Sim.Freq);
RollSP2  = Polinomio(20,30,0,-40,0,0,Sim.Ts*Sim.Freq,Sim.Tfinal-Sim.Ts*Sim.Freq);
SP.Roll  = 0*(RollSP1 + RollSP2)*(pi/180);

end