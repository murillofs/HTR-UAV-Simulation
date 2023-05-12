%==========================================================================
% From the NED frame TO the BF frame
%
% This function transforms a six-dimensional vector in the (inertial) North
% -East-Down (NED) reference frame into a vector in the Body-Fixed (BF)
% reference frame. The vector has to be comprised of two three-dimensional
% subvectors, the 1st regarding linear quantities, e.g. forces, linear ac-
% celerations, or linear velocities, and the 2nd regarding angular quan-
% tities, e.g. moments, angular accelerations, or angular velocities
%==========================================================================
function BFVector = NED2BF(EulerAngle, NEDVector) % MATHAUS - PRA MIM NADA AQUI TÁ FAZENDO SENTIDO - MELHOR FAZE SEM ESSA SIMPLIFICAÇÃO TODA
% Pre-computations
ca1 = cos(EulerAngle);

% Linear part (3x3)
RxPhiT   = ca1;

linNEDToBF = RxPhiT^(-1);

angBFToNED = linNEDToBF;

%% Vector in the BF frame

Matrix = inv([linNEDToBF 0;
          0          angBFToNED]); 

BFVector = Matrix*NEDVector;