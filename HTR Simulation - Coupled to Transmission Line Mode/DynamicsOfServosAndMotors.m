%=====================================================
% This function calculates the servos and motors dynamics considering a
% first order linear system
% ps.: Using 4-Order Runge-Kutta Integration Method
%=====================================================

function DynamicsOfServosAndMotors (stepNumber)

    % Global Variables
    global Sim APP SimOutput

    % Engine and Servos dynamics - Considering First-Order Linear System
    tau = [APP.tau_mt; APP.tau_mt; APP.tau_mt; APP.tau_mt; APP.tau_mt; APP.tau_mt; APP.tau_srv; APP.tau_srv];
    
    % ---------------------------------------------------------------------
    % Get the Servo and Motor Dynamics from new methodology
    % Reference signals of Servos and Motors to be considered before to apply their dynamics
    RefSignal    = [SimOutput.Motors(:,stepNumber); SimOutput.Servos(:,stepNumber)];
    
    if stepNumber==1        
        ActualSignal = zeros(8,1);
    else
        ActualSignal = [SimOutput.Motors(:,stepNumber-1); SimOutput.Servos(:,stepNumber-1)];    
    end
    
    AuxVector = (RefSignal - ActualSignal)./tau;

    % 4-Order Runge-Kutta Integration Method
    s1 = AuxVector;
    s2 = AuxVector + (Sim.Ts/3)*s1;
    s3 = AuxVector + 2*(Sim.Ts/3)*s2;
    s4 = AuxVector + Sim.Ts*s3;

    AuxVector = ActualSignal + (Sim.Ts/8)*(s1 + 3*s2 + 3*s3 + s4);

    SimOutput.Motors(:,stepNumber) = AuxVector(1:6);
    SimOutput.Servos(:,stepNumber) = AuxVector(7:8);
end