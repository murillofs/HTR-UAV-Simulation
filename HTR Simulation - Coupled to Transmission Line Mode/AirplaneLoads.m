%==========================================================================
% This function computes the net forces and moments acting on the airplane
%
% [Guillaume J. J. Ducard. Fault-tolerant flight control and guidance sys-
% tems: practical methods for small unmanned aerial vehicles. Advances in
% Industrial Control Series. Springer-Verlag, London, UK, 2009, p. 41]
%==========================================================================
function AirplaneLoads(stp)

global APP SP Sim SimOutput;

% Converts forces which stem from the weight.
Aux = sin(SimOutput.Arfagem_Line(stp))*APP.g*APP.mass;

% PWM Calculation for Servomotors and Propulsion Motors
PWM_MotorsAndServos_New (stp)

% Calculation of Servo and Motor's Dynamics
PWM_MotorsAndServos_Dynamics_TRUAV(stp)  

Sim.Gravity (stp) = - Aux; 

Sim.NetForcesAndMoments =  [Sim.Vx;Sim.T_Roll] + [Sim.Gravity(stp); 0];

% Saves this(these) result(s) for later use
SimOutput.NetForcesAndMoments(:, stp) = Sim.NetForcesAndMoments;
end