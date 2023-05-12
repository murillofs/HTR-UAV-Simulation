%==========================================================================
% From the BF frame TO the Wind frame
%
% This function transforms a three-dimensional vector in the Body-Fixed
% (BF) reference frame into a vector in the Wind reference frame. The vec-
% tor regards linear quantities, e.g. forces, linear accelerations, or lin-
% ear velocities
%
% [Guillaume J. J. Ducard. Fault-tolerant flight control and guidance sys-
% tems: practical methods for small unmanned aerial vehicles. Advances in
% Industrial Control Series. Springer-Verlag, London, UK, 2009, p. 31]
%==========================================================================

function WindVector = BF2Wind(Angles, BFVector)

% Pre-computations
Ralpha = [cos(Angles(1)) 0 sin(Angles(1)); 0 1 0; -sin(Angles(1)) 0 ...
    cos(Angles(1))];
Rbeta = [cos(Angles(2)) sin(Angles(2)) 0; -sin(Angles(2)) cos(Angles(2))...
    0; 0 0 1];

% Vector in the Wind frame
WindVector = Rbeta*Ralpha*BFVector;