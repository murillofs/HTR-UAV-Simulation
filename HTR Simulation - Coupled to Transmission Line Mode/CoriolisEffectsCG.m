%==========================================================================
% This function returns the total Coriolis effects based on: i) the mass of
% the rigid-body; ii) the tensor of inertia of the rigid-body with respect
% to its Centre of Gravity (CG); and iii) the angular velocities (they are
% the same in both the (inertial) North-East-Down (NED) and the Body-Fixed
% (BF) reference frames). The origin of the BF frame coincides with the CG
%==========================================================================

function CECG = CoriolisEffectsCG(mass, ICG, velBFFrame)

% Pre-computations
SvelBFFrame = [0             -velBFFrame(6)     velBFFrame(5);
               velBFFrame(6)  0                -velBFFrame(4); 
              -velBFFrame(5)  velBFFrame(4)     0];
          
AuxVector = ICG * velBFFrame(4:6);

SAuxVector = [0           -AuxVector(3)  AuxVector(2); 
              AuxVector(3) 0            -AuxVector(1);
             -AuxVector(2) AuxVector(1)  0];

% Total Coriolis effects
CECG = [mass*SvelBFFrame zeros(3); zeros(3) -SAuxVector] * velBFFrame;