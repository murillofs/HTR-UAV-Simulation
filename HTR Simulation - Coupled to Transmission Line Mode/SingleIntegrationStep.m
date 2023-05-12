%==========================================================================
% This function implements a double integrator that performs a single inte-
% gration step using one of the available numerical integration methods. It
% also handles the condition when the airplane is on the ground
%==========================================================================

function [linAndAngVel, posAndAtt] = SingleIntegrationStep

% Global variable(s)
global APP Sim;

% Double integrator
AuxFunction = [APP.InverseInertiaMatrix*Sim.NetForcesAndMoments;
    BF2NED(Sim.CurrentPositionAndAttitude(2),Sim.CurrentVelocitiesBFFrame)];

IntMethod = 1;
if IntMethod == 0
    % Method 1: Forward Euler method
    AuxVector = Sim.Ts*AuxFunction;
    
else
    % Method 2: Explicit 4th-order Runge-Kutta method (default)
    s1 = AuxFunction;
    s2 = AuxFunction + (Sim.Ts/3)*s1;
    s3 = AuxFunction + 2*(Sim.Ts/3)*s2;
    s4 = AuxFunction + Sim.Ts*s3;
    
    AuxVector = (Sim.Ts/8)*(s1 + 3*s2 + 3*s3 + s4);
end

% Accumulates by adding the newest computed value (1 step ahead)
AuxVector = [Sim.CurrentVelocitiesBFFrame;Sim.CurrentPositionAndAttitude] + AuxVector;

% Both vectors (double integration) are splitted
linAndAngVel = AuxVector(1:2);
posAndAtt    = AuxVector(3:4);