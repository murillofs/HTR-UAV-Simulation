%==========================================================================
% This function implements the controller
%==========================================================================

function Controller_High_Level(stepNumber)

% Global variable(s)
global APP Ctrl Sim SimOutput;

% Altitude control - MISO system - Algorithm: PID
Ctrl.errPPosInert = [0; 0; SimOutput.AltitudeSP(stepNumber)] - [0; 0; Sim.Altitude] ;
Ctrl.errIPosInert = Ctrl.errIPosInertPrev + (Sim.Ts/2)*(Ctrl.errPPosInert + Ctrl.errPPosInertPrev);
Ctrl.errDPosInert = (Ctrl.errPPosInert - Ctrl.errPPosInertPrev)/Sim.Ts;

% Applying Low-Pass Filter Action
Ctrl.errDPosInert = Ctrl.errDPosInertPrev + [APP.d_lpf_alphaInert; APP.d_lpf_alphaInert; APP.d_lpf_alphaInert].*(Ctrl.errDPosInert - Ctrl.errDPosInertPrev);

Ctrl.errPPosInertPrev = Ctrl.errPPosInert;
Ctrl.errIPosInertPrev = Ctrl.errIPosInert;
Ctrl.errDPosInertPrev = Ctrl.errDPosInert;

Ctrl.kPPosInert(1,1) = 56;
Ctrl.kIPosInert(1,1) = 0.1;
Ctrl.kDPosInert(1,1) = 0;

Sim.PropulsionRef = Ctrl.kPPosInert*Ctrl.errPPosInert + Ctrl.kIPosInert*Ctrl.errIPosInert + Ctrl.kDPosInert*Ctrl.errDPosInert;

% Saturation

Sim.PropulsionRef(Sim.PropulsionRef >)

if  (Sim.PropulsionRef(1) > 45)
    Sim.PropulsionRef(1) = 45;
else
    if (Sim.PropulsionRef(1) < -45)
        Sim.PropulsionRef(1) = -45;
    end
end

if  (Sim.PropulsionRef(2) > APP.Sat_East_Angle)
    Sim.PropulsionRef(2) = APP.Sat_East_Angle;
else
    if (Sim.PropulsionRef(2) < -APP.Sat_East_Angle)
        Sim.PropulsionRef(2) = -APP.Sat_East_Angle;
    end
end

if  (Sim.PropulsionRef(3) > APP.Sat_Prop)
    Sim.PropulsionRef(3) = APP.Sat_Prop;
else
    if (Sim.PropulsionRef(3)  < 0)
        Sim.PropulsionRef(3) = 0;
    end
end
% Case if it is not necessary to calculate the Control Action due to Successive Loop Closure
else
    Sim.PropulsionRef = SimOutput.PropulsionRef(:,stepNumber-1);
end

% Saves this(these) result(s) for later use
SimOutput.PropulsionRef(:,stepNumber) = Sim.PropulsionRef;