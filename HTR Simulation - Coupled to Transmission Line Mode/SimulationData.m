%==========================================================================
% This function holds the simulation data
%==========================================================================

function SimulationData

% Global variable(s)
global Ctrl Sim;

% Total simulation time [s]
Sim.tFinal = 40;

% Integration step / sampling period [s]
Sim.Ts = 0.01;

% Initial linear and angular velocities, position, and attitude
Sim.VelocitiesBFFrame0   = zeros(6, 1);
Sim.PositionAndAttitude0 = zeros(6, 1);

% Altitude controller gains (SISO system)
KP_Vx = 7;
KI_Vx = 1;
KD_Vx = 0.3;

KP_Pe = 0;
KI_Pe = 0;
KD_Pe = 0;

KP_Alt = 4;
KI_Alt = 1.2;            
KD_Alt = 2;

% Angular Attitude controller gains (MIMO system)
KP_Roll1  = 5;
KP_Pitch1 = KP_Roll1;
KP_Yaw1   = KP_Roll1;

KI_Roll1  = 0;
KI_Pitch1 = KI_Roll1;
KI_Yaw1   = KI_Roll1;

% Velocity Attitude controller gains (MIMO system)
KP_Roll2 = 1;
KI_Roll2 = 0.2;
KD_Roll2 = 0.1;

KP_Pitch2 = 1;
KI_Pitch2 = 0.2;
KD_Pitch2 = 0.1;

KP_Yaw2 = 1;
KI_Yaw2 = 0.2;
KD_Yaw2 = 0.1;

% Velocity Position Matrix Gains
Ctrl.kPAtt1 = [KP_Roll1 0          0;
               0       KP_Pitch1   0;
               0        0          KP_Yaw1];
           
Ctrl.kIAtt1 = [KI_Roll1 0          0;
               0       KI_Pitch1   0;
               0        0          KI_Yaw1];
           

% Angular Position Matrix Gains
Ctrl.kPAtt2 = [KP_Roll2 0          0;
               0        KP_Pitch2  0;
               0        0          KP_Yaw2];

Ctrl.kIAtt2 = [KI_Roll2 0          0;
               0        KI_Pitch2  0;
               0        0          KI_Yaw2];

Ctrl.kDAtt2 = [KD_Roll2 0          0;
               0        KD_Pitch2  0;
               0        0          KD_Yaw2];

% Inertial Position Gains
Ctrl.kPPosInert = [KP_Vx  0       0;
                   0      KP_Pe   0;
                   0      0       KP_Alt];

Ctrl.kIPosInert = [KI_Vx 0        0;
                   0      KI_Pe   0;
                   0      0       KI_Alt];

Ctrl.kDPosInert = [KD_Vx 0        0;
                   0      KD_Pe   0;
                   0      0       KD_Alt];  