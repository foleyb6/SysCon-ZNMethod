function action = set_pwm(device, pwm_value)
%% Sets the PWM of the fan
% Inputs:
%  ~ device: serialport object controlling the real world system
%  ~ pwm_value: A value from 0 to 4095 to set the pulse width modulation of
%  the actuator
% Outputs:
%  ~ action: the control action to change the PWM
%
% Created by:  Kyle Naddeo 2/4/2022
% Modified by: YOUR NAME and DATE

%% Force PWM value to be valid
if pwm_value > 4095
    pwm_value = 4095;
elseif pwm_value < 1500
    pwm_value = 1500;
end

%% Send Command
action = sprintf('P%04.f', pwm_value);
write(device,"F", "string");
write(device,action, "string");

end
