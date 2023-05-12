function [value] = Saturation(value, Sup, Min)

% Upper Saturation
value(value>Sup) = Sup;

% Lower Saturation
value(value<Min) = Min;

end