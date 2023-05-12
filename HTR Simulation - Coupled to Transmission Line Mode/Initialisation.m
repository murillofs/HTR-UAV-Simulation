
function Initialisation
% Closes all figures and clears all variables and functions from memory
clear all; close all;  clc;

% Global variable(s)
global Ctrl Sim SimOutput Time Time2 r2d d2r;
%% Time
Tfinal = 86;    % Tempo total de simulação
Ts     = 0.01;  % StepSize
Freq   = 5;     % SLC frequency

Time   = 0:Ts:Tfinal-Ts;            
Time2  = 0:Ts/Freq:Tfinal-Ts/Freq;  

r2d = (180/pi);
d2r = (pi/180);

%% Data for the Power Transmission Line

a = 0.0007;
L = 500;

%% Control data structure (Ctrl)
% Inertial Position controller gains
KP_Px = 1; 

% Innertial Position controller gains
KP_Roll = 17.38;

% Innertial Velocity controller gains
KP_VX = 20;  
KI_VX = 0.1; 
KD_VX = 2; 

% Angular Velocity controller gains
KP_VRoll = 15.98;
KI_VRoll = 0.1326;
KD_VRoll = 2.5194;

% Matrix Gains

kPPosi = [KP_Px 0;
          0     KP_Roll];
      
kPVelo = [KP_VX 0;
          0     KP_VRoll];
      
kIVelo = [KI_VX 0;
          0     KI_VRoll];
      
kDVelo = [KD_VX 0;
          0     KD_VRoll];
                      
% Erro Previo de controle
errPPosiPrev = zeros(2, 1);
errIPosiPrev = zeros(2, 1);
errPVeloPrev = zeros(2, 1);
errIVeloPrev = zeros(2, 1);
errPPosiYawPrev = 0;
errIPosiYawPrev = 0;

Ctrl = struct('kPPosi',kPPosi,'kPVelo',kPVelo,'kIVelo',kIVelo,'kDVelo',kDVelo,...
    'errPPosiPrev',errPPosiPrev,'errIPosiPrev',errIPosiPrev,'errPPosiYawPrev',errPPosiYawPrev,...
    'errIPosiYawPrev',errIPosiYawPrev,'errIVeloPrev',errIVeloPrev,'errPVeloPrev',errPVeloPrev);

CurrentPositionAndAttitude = [-250; 0];
CurrentVelocitiesBFFrame   = zeros(2, 1);
Torq_Roll                  = [];

Sim = struct('CurrentPositionAndAttitude', CurrentPositionAndAttitude,...
    'CurrentVelocitiesBFFrame', CurrentVelocitiesBFFrame,...
    'Tfinal', Tfinal,'Ts', Ts/Freq,'Freq', Freq, 'a', a, 'L', L, ...
    'T_Roll', Torq_Roll);


%% Simulation output data structure (SimOutput)

NetForcesAndMoments = [];
PositionAndAttitude = [];
VelocitiesBFFrame   = [];
Vx                  = [];
Servos              = zeros(2,1);
Motors              = zeros(6,1);
Arf                 = [];

SimOutput = struct('NetForcesAndMoments', NetForcesAndMoments,'Torq_Roll',Torq_Roll,...
    'PositionAndAttitude',PositionAndAttitude, 'VelocitiesBFFrame',...
    VelocitiesBFFrame,'Vx', Vx, 'Motors', Motors, 'Servos', Servos, 'Arfagem_Line', Arf);
