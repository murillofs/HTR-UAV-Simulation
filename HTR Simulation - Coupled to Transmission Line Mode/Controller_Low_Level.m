%==========================================================================
% This function implements the controller
%==========================================================================

function Controller_Low_Level(stepNumber)

% Global variable(s)
global APP Ctrl Sim SimOutput;

% ------------------------------------------------------
% Angular Attitude Position Control - Algorithm: P
Ctrl.errPAtt1 = (pi/180)*[SimOutput.RollSP(stepNumber); SimOutput.PitchSP(stepNumber); SimOutput.YawSP(stepNumber)] - Sim.CurrentPositionAndAttitude(4:6) + 0*pi/180*[0.1*randn(1); 0.1*randn(1); 0.1*randn(1)];
Ctrl.errIAtt1 = Ctrl.errIAtt1Prev + (Sim.Ts/2)*(Ctrl.errPAtt1 + Ctrl.errPAtt1Prev);

Ctrl.errPAtt1Prev = Ctrl.errPAtt1;
Ctrl.errIAtt1Prev = Ctrl.errIAtt1;

AuxVector = Ctrl.kPAtt1*Ctrl.errPAtt1 + Ctrl.kIAtt1*Ctrl.errIAtt1;

% Saturation of Angular Attitude Control
% Rolling Dynamics
if  (AuxVector(1) > APP.Sat_RollPitchYawAngle)
     AuxVector(1) = APP.Sat_RollPitchYawAngle;
else
    if (AuxVector(1) < -APP.Sat_RollPitchYawAngle)
        AuxVector(1) = -APP.Sat_RollPitchYawAngle;
    end
end

% Pitching Dynamics
if  (AuxVector(2) > APP.Sat_RollPitchYawAngle)
     AuxVector(2) = APP.Sat_RollPitchYawAngle;
else
    if (AuxVector(2) < -APP.Sat_RollPitchYawAngle)
        AuxVector(2) = -APP.Sat_RollPitchYawAngle;
    end
end

% Yawing Dynamics
Sim.NonSatYawTorque = AuxVector(3);
if  (AuxVector(3) > APP.Sat_RollPitchYawAngle)
     AuxVector(3) = APP.Sat_RollPitchYawAngle;
else
    if (AuxVector(3)  < -APP.Sat_RollPitchYawAngle)
        AuxVector(3) =  -APP.Sat_RollPitchYawAngle;
    end
end

% ------------------------------------------------------
% Velocity Attitude control - MIMO system - Algorithm: PID
Ctrl.errPAtt2 = AuxVector - Sim.CurrentVelocitiesBFFrame(4:6) + 0*pi/180*[0.1*randn(1); 0.1*randn(1); 0.1*randn(1)];
Ctrl.errIAtt2 = Ctrl.errIAtt2Prev + (Sim.Ts/2)*(Ctrl.errPAtt2 + Ctrl.errPAtt2Prev);
Ctrl.errDAtt2 = (Ctrl.errPAtt2 - Ctrl.errPAtt2Prev)/Sim.Ts;

% Applies Low-Pass Filter Action
Ctrl.errDAtt2 = Ctrl.errDAtt2Prev + [APP.d_lpf_alphaRollPitch; APP.d_lpf_alphaRollPitch; APP.d_lpf_alphaYaw].*(Ctrl.errDAtt2 - Ctrl.errDAtt2Prev);

Ctrl.errPAtt2Prev = Ctrl.errPAtt2;
Ctrl.errIAtt2Prev = Ctrl.errIAtt2;
Ctrl.errDAtt2Prev = Ctrl.errDAtt2;

AuxVector = Ctrl.kPAtt2*Ctrl.errPAtt2 + Ctrl.kIAtt2*Ctrl.errIAtt2 + Ctrl.kDAtt2*Ctrl.errDAtt2;

% Saturation of Velocity Attitude Control
% Rolling Dynamics
if  (AuxVector(1) > APP.Sat_RollPitch_Torq)
     AuxVector(1) = APP.Sat_RollPitch_Torq;
else
    if (AuxVector(1) < -APP.Sat_RollPitch_Torq)
        AuxVector(1) = -APP.Sat_RollPitch_Torq;
    end
end

% Pitching Dynamics
if  (AuxVector(2) > APP.Sat_RollPitch_Torq)
     AuxVector(2) = APP.Sat_RollPitch_Torq;
else
    if (AuxVector(2) < -APP.Sat_RollPitch_Torq)
        AuxVector(2) = -APP.Sat_RollPitch_Torq;
    end
end

% Yawing Dynamics
if  (AuxVector(3) > APP.Sat_RollPitch_Torq/APP.factorK1toK2)
     AuxVector(3) = APP.Sat_RollPitch_Torq/APP.factorK1toK2;
else
    if (AuxVector(3)  < -APP.Sat_RollPitch_Torq/APP.factorK1toK2)
        AuxVector(3) =  -APP.Sat_RollPitch_Torq/APP.factorK1toK2;
    end
end

Sim.T_Roll  = AuxVector(1);
Sim.T_Pitch = AuxVector(2);
Sim.T_Yaw   = AuxVector(3);

% Saves this(these) result(s) for later use
SimOutput.Torq_Roll(stepNumber)  = Sim.T_Roll;
SimOutput.Torq_Pitch(stepNumber) = Sim.T_Pitch;
SimOutput.Torq_Yaw(stepNumber)   = Sim.T_Yaw;