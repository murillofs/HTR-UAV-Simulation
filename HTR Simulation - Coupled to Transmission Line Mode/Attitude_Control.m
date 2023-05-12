%==========================================================================
% This function implements the controller
%==========================================================================

function Attitude_Control(stp,SPstep)

global Ctrl Sim SimOutput SP Sat;
% Velocity control - MIMO system - Algorithm: PID
SP.VelocitySP(:,stp) = [SimOutput.PropulsionForce(SPstep);SP.AttitudeSP(SPstep)]; 

errPVelo = SP.VelocitySP(:,stp)  - Sim.CurrentVelocitiesBFFrame;
errIVelo = Ctrl.errIVeloPrev + (Sim.Ts/2)*(errPVelo + Ctrl.errPVeloPrev);
errDVelo = -Sim.CurrentVelocitiesBFFrame;                                % Feedback of Speed Control
Ctrl.errPVeloPrev = errPVelo;
Ctrl.errIVeloPrev = errIVelo;

VxRoll = Ctrl.kPVelo*errPVelo + Ctrl.kIVelo*errIVelo + Ctrl.kDVelo*errDVelo;

VxRoll(1) = Saturation(VxRoll(1),Sat.Sat_Vx,-Sat.Sat_Vx);
VxRoll(2) = Saturation(VxRoll(2),Sat.Sat_Roll_Torq,-Sat.Sat_Roll_Torq);

Sim.Vx     = VxRoll(1);
Sim.T_Roll = VxRoll(2);

% Saving the theta angle considering the catenary X position
SimOutput.Arfagem_Line(stp) = atan(sinh(Sim.a*Sim.CurrentPositionAndAttitude(1)));

% Saves this(these) result(s) for later use
SimOutput.Torq_Roll(stp) = Sim.T_Roll;
SimOutput.Vx(stp)        = Sim.Vx; %Sim.propulsionForce;%

end