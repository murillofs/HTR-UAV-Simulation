%==========================================================================
% This is the main function. It is responsible for carrying out the simula-
% tion and also for presenting the results on the screen.
%==========================================================================
clear all; close all; clc;
%% Initialisation
Initialisation;

%% Creates SetPoints
SetPointsCreation;

%% Global variable(s) - MUST COME HERE, strictly after the initialisation
global Sim SimOutput Time SP;

%% Loads the simulation data
AirplanePhysicalProperties;

tic;
for j = 1:numel(Time)
    
    Position_Control(j);
    
    for  i = Sim.Freq*(j-1)+1:Sim.Freq*(j)
        
        Attitude_Control(i,j);
        AirplaneLoads(i);
        
        [SimOutput.VelocitiesBFFrame(:,i),SimOutput.PositionAndAttitude(:,i)] = SingleIntegrationStep;
        
        Sim.CurrentPositionAndAttitude = SimOutput.PositionAndAttitude(:, i);
        Sim.CurrentVelocitiesBFFrame   = SimOutput.VelocitiesBFFrame(:, i);
        
        %Calculating HTR Y position in the Catenary
        SimOutput.y_HTR(i)             = SP.h_tower + (exp(Sim.a*SimOutput.PositionAndAttitude(1,i)) + exp(-Sim.a*SimOutput.PositionAndAttitude(1,i)) - 2)/(2*Sim.a);
    end
    
    %% Prints notifications ever 10 times
    if (mod(i,50)==0)
        Percent = sprintf('%0.2f%%  Seconds:%0.2f%', (i-1)/((Sim.Tfinal)/Sim.Ts)*100, ((i-1)/(1/Sim.Ts)))
    end
end

%% Stops and reads the stopwatch timer
elapsedTime = toc;
fprintf('Total simulation time = %0.4fs\n', elapsedTime);

%% Plots the several graphics of interest
plotGeneral

%% End of the script
delete *.asv;