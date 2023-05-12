%==========================================================================
% This is the function that calculates the PWM signals to be sent to the
% motors and optimize the servo position angles.
%==========================================================================

function PWM_MotorsAndServos_New (stepNumber)

global Sim SimOutput APP

CTRL_IN   = real([Sim.Vx;Sim.T_Roll]);

Min_Error_2       = 1e-6;
Min_Error_Delta_U = 1e-3;

if stepNumber==1
    Ang       = SimOutput.Servos(:,stepNumber);
    Mot_rot   = SimOutput.Motors(:,stepNumber);
else
    Ang       = SimOutput.Servos(:,stepNumber-1);
    Mot_rot   = SimOutput.Motors(:,stepNumber-1);
end

PWM_Internal    = [];
Servos_Internal = [];

it = 1;
t_start = tic;
for i=1:it
    [CTRL_OUT_T1, CTRL_OUT_T2, CTRL_OUT_1, CTRL_OUT_2, Servos, PWM] = ForcesTorqueAngles_to_PWM_TRUAV_2(CTRL_IN, Ang, Mot_rot);
    PWM_Internal (:,i)    = PWM;
    Servos_Internal (:,i) = Servos;
    
    %% Convergence Analisys 1 - i=1
    if i==1
        Delta_U = real(mean(([Mot_rot; Ang] - [PWM_Internal(:,i); Servos_Internal(:,i)])./...
            [APP.MaxPWM; APP.MaxPWM; APP.MaxPWM; APP.MaxPWM; APP.MaxPWM; APP.MaxPWM;...
            APP.Amp_Servos; APP.Amp_Servos]));
    else
        %% Convergence Analisys 1 - i>1
        Delta_U = real(mean(([PWM_Internal(:,i-1); Servos_Internal(:,i-1)] - [PWM_Internal(:,i); Servos_Internal(:,i)])./...
            [APP.MaxPWM; APP.MaxPWM; APP.MaxPWM; APP.MaxPWM; APP.MaxPWM; APP.MaxPWM;...
            APP.Amp_Servos; APP.Amp_Servos]));
    end
    
    %% Convergence Analisys 2
    aux_T1 = sum((([CTRL_IN(1);0] - real([CTRL_OUT_T1(1);0])).^2))/length(CTRL_OUT_T1);
    aux_T2 = sum(((CTRL_IN - real(CTRL_OUT_T2)).^2))/length(CTRL_OUT_T2);
    
    aux_1 = sum((([CTRL_IN(1);0] - real([CTRL_OUT_1(1);0])).^2))/length(CTRL_OUT_1);
    aux_2 = sum(((CTRL_IN - real(CTRL_OUT_2)).^2))/length(CTRL_OUT_2);
    
    SimOutput.ME_1(i,stepNumber)  = mean(aux_1);
    SimOutput.ME_2(i,stepNumber)  = mean(aux_2);
    
    SimOutput.ME_T1(i,stepNumber) = mean(aux_T1);
    SimOutput.ME_T2(i,stepNumber) = mean(aux_T2);
    
    SimOutput.Delta_U(i,stepNumber) = abs(Delta_U);
    
    if (SimOutput.ME_T2(i,stepNumber)<=Min_Error_2) && (SimOutput.Delta_U(i,stepNumber)<=Min_Error_Delta_U)
        break;
    end
end
SimOutput.Time_Elaps_New(stepNumber)   = toc(t_start);
SimOutput.ItConverg_FDCA(stepNumber)   = i;
SimOutput.MeanError(stepNumber)        = SimOutput.ME_T2(i,stepNumber);
SimOutput.ActutatorError(i,stepNumber) = SimOutput.Delta_U(i,stepNumber);

% Saves the Required Motors PWM and Servo Angular Position
SimOutput.Motors(:,stepNumber)    = PWM;
SimOutput.Servos(:,stepNumber)    = Servos;
end
