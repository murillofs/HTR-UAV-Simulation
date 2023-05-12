% ============================================================
% Low Pass Filter
% ============================================================

function d_lpf_alpha = LowPassFilter__d_lpf_alpha(Cutt_Off_Freq, dt)
  
    rc = 1/(2*pi*Cutt_Off_Freq);
    d_lpf_alpha = dt/(dt + rc);
  
end