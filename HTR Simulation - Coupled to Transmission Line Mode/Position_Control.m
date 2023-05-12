function  Position_Control(step)

global Ctrl Sat Sim SimOutput SP;

%% Px Position Inertial Controller
errPosi_Px = SP.Position(step) - Sim.CurrentPositionAndAttitude(1);
SP.Fx      = Ctrl.kPPosi(1,1)*errPosi_Px;
SP.Fx      = Saturation(SP.Fx,Sat.Sat_Vel_X,-Sat.Sat_Vel_X);

%% Roll Position Angular Controller
errPosi_Roll = SP.Roll(step) - Sim.CurrentPositionAndAttitude(2);
SP.R         = Ctrl.kPPosi(2,2)*errPosi_Roll;
SP.R         = Saturation(SP.R,Sat.Sat_Vel_Roll,-Sat.Sat_Vel_Roll);

SP.AttitudeSP(step)              = SP.R;
SimOutput.PropulsionForce(step)  = SP.Fx;

end