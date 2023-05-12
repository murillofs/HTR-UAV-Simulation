%==========================================================================
% This function creates the allocation of torques and forces along motors
% and servos placed in the vehicle.
%==========================================================================

function M_TiltQuad = ServoAndMotorsAllocationMatrix (Servos)

global APP

f = APP.l*0.5;

ag1_c = cosd(Servos(1));
ag2_c = cosd(Servos(2));

ag1_s = sind(Servos(1));
ag2_s = sind(Servos(2));

M_TiltQuad = [-APP.k1*ag1_s                       APP.k1*ag2_s                           0            0            0          0;
             (-APP.k1*ag1_c*APP.l+APP.k2*ag1_s)  (APP.k1*ag2_c*APP.l-APP.k2*ag2_s)      APP.k1*f    -APP.k1*f    -APP.k1*f   APP.k1*f];

end