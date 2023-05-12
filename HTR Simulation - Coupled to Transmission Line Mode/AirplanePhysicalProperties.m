%==========================================================================
function AirplanePhysicalProperties
% Global variable(s)
global APP Sat;

% HTR Physical Properties data structure
M = 9.1;     
L = 0.5;

Ix  = 1.107033;  % HTR Ix inertia tensor [kg*m^2]
          
IM   = [M   0;
        0   Ix];  % Inertia matrix (2x2)

% Time constants [s]
settling_time_mt  = 0.1; %0.25
settling_time_srv = 0.5;  %1.5

% Motors e Servomotors
tau_mt  = settling_time_mt/5;    % Motors
tau_srv = settling_time_srv/5;   % Servos 

% Maximum Thrust in kg
MaxThusrt = 1;    

% Gravitational Constant
g = 9.80665;

% Constants of motors
k1 = 28.75;
k2 = 0.80;

% Maximum PWM Variation
MaxPWM = 1;       %[us]

% Maximum Servomotor Angle
Amp_Servos            = 90;

%% Saturation Structure
Sat_Vel_Roll = 5*(pi/180); % rad/s2
Sat_Vel_X    = 20/3.6; % 30 Km/h converted in m/seg

Sat_Vx        = k1*2;      
Sat_Roll_Torq = 4*k1*L*cosd(60); 

% Low-Pass Filter Data
AttLoop_Frequency   = 400;

Att_Cutt_Off_Freq    = AttLoop_Frequency/5;     % Attitude Loop Frequency 400 Hz
d_lpf_Roll_Fx = LowPassFilter__d_lpf_alpha(Att_Cutt_Off_Freq,   1/AttLoop_Frequency); 

Sat = struct('Torque',Sat_Roll_Torq, 'Sat_Vel_Roll',Sat_Vel_Roll, 'Sat_Vel_X', Sat_Vel_X, ...
             'Sat_Vx',Sat_Vx, 'Sat_Roll_Torq',Sat_Roll_Torq);

APP = struct('Name', 'Airplane Physical Properties (APP)', 'mass', M,...
    'InertiaMatrix', IM, 'InverseInertiaMatrix', IM\eye(2), ... 
    'g', g, 'l', L, 'k1', k1, 'k2', k2, 'MaxPWM', MaxPWM, 'MaxThusrt', MaxThusrt, ...
    'tau_mt', tau_mt, 'tau_srv', tau_srv, 'Amp_Servos', Amp_Servos,...
    'd_lpf_Roll_Fx', d_lpf_Roll_Fx);