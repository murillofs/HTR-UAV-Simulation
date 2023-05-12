function [IN_CTRL_OUT_T1, IN_CTRL_OUT_T2, IN_CTRL_OUT_1, IN_CTRL_OUT_2, SEN, OUT2] = ForcesTorqueAngles_to_PWM_TRUAV_2(IN_CTRL, IN_Angles, Mot_Rot)

global APP

f = APP.l*0.5;

if IN_CTRL(1)==0
    IN_Angles = [0; 0];
elseif IN_CTRL(1)>0
    IN_Angles = [-90; 90];
elseif IN_CTRL(1)<0
    IN_Angles = [90; -90];
end

%-------------------------------------------
% First Part - Obtaining Propulsion Motor Rotation for Motor 1 and 2
%-------------------------------------------

ag1_s     = sind(IN_Angles(1));
ag2_s     = sind(IN_Angles(2));

M_TiltQuad2  = [-APP.k1*ag1_s APP.k1*ag2_s];
M_Inv_TQuad2 = pinv(M_TiltQuad2);
Mot_Rot      = M_Inv_TQuad2*IN_CTRL(1);
SEN          = IN_Angles;

%%-------------------------------------
% Checking Estimated Values - Stage 1

IN_CTRL_OUT_1 = 0; 
IN_CTRL_OUT_2 = 0;

%% -----------------------------------------
%-------------------------------------------
% Second Part - Obtaining Propulsion Motor Rotation for Motor 3, 4, 5 and 6
%-------------------------------------------

if IN_CTRL(2)<0
    M_TiltQuad1   = [-APP.k1*f    -APP.k1*f];
    M_Inv_TQuad1 = pinv(M_TiltQuad1);
    OUT2         = M_Inv_TQuad1*IN_CTRL(2);
    OUT2         = [Mot_Rot; 0; OUT2; 0];
elseif IN_CTRL(2)>0
    M_TiltQuad1   = [APP.k1*f    APP.k1*f];
    M_Inv_TQuad1 = pinv(M_TiltQuad1);
    OUT2         = M_Inv_TQuad1*IN_CTRL(2);
    OUT2         = [Mot_Rot; OUT2(1); 0; 0; OUT2(2)];
else
    OUT2         = [Mot_Rot; zeros(4,1)];
end

%%-------------------------------------
% Checking Final Estimated Values
                 
IN_CTRL_OUT_T1 = 0;%M_TiltQuad1*OUT2;
IN_CTRL_OUT_T2 = 0;%M_TiltQuadCompleto*OUT2;

end