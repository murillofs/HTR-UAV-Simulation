%==========================================================================
% From the BF frame TO the NED frame
%
% This function transforms a six-dimensional vector in the Body-Fixed (BF)
% reference frame into a vector in the (inertial) North-East-Down (NED)
% reference frame. The vector has to be comprised of two three-dimensional
% subvectors, the 1st regarding linear quantities, e.g. forces, linear ac-
% celerations, or linear velocities, and the 2nd regarding angular quan-
% tities, e.g. moments, angular accelerations, or angular velocities
%==========================================================================

function NEDVector = BF2NED(EulerAngle, BFVector)

% Pre-computations
ca1 = cos(EulerAngle);

% Linear part (3x3)
RxPhi   = ca1;

linBFToNED = RxPhi;

angBFToNED = ca1  ;

% Complete frame transformation matrix (6x6)
Matrix = [linBFToNED 0;
          0          angBFToNED];

% Vector in the NED frame
NEDVector = Matrix*BFVector;