function PWM_MotorsAndServos_Dynamics_TRUAV (stepNumber)

global SimOutput Sim

% Calculates the Dynamics Responses of Servos and Motors, due to their Characteristics
DynamicsOfServosAndMotors(stepNumber);

% Calculate the Controlled Action delivered to the Aircraft after considering the motors and servos dynamics
AlocationMatrix = ServoAndMotorsAllocationMatrix(SimOutput.Servos(:,stepNumber));
OUT    = AlocationMatrix*SimOutput.Motors(:,stepNumber);

% Saves the actual values 
Sim.Vx     = OUT(1);
Sim.T_Roll = OUT(2);

% Saves the FOB = minimization of PWM signals
SimOutput.PWMFob(stepNumber) = sum(SimOutput.Motors(1:6,stepNumber));

% Saving the actual values for future use
SimOutput.Vx(:,stepNumber)      = Sim.Vx;
SimOutput.Torq_Roll(stepNumber) = Sim.T_Roll;

end