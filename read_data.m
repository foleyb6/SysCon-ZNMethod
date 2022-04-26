function [distance,pwm,target,deadpan] = read_data(device)
%% Reads data sent back from Ball and Pipe system
% Inputs:
%  ~ device: serialport object controlling the real world system
% Outputs:
%  ~ distance: the IR reading from the time of flight sensor
%  ~ pwm: the PWM from the manual knob of the system (NOT THE SAME AS THE
%  PWM YOU MAY SET THROUGH SERIAL COMMUNICATION)
%  ~ target: the desired height of the ball set by the manual knob of the
%  system
%  ~ deadpan: the time delay after an action set by the manual knob of the
%  system
%
% Created by:  Kyle Naddeo 1/3/2022
% Modified by: YOUR NAME and DATE

%% Ask nicely for data
write(device,'H', 'String');
write(device, 'S', 'string');

%% Read data
Data = read(device,20,'string');

%% Translate
% translate the response to 4 doubles using str2double() and
%  extractBetween() % (Hint: the response is in the spec sheet)
 distance   = str2double(extractBetween(Data, 2, 5));
 pwm = str2double(extractBetween(Data, 7, 10));
 target     = str2double(extractBetween(Data, 12, 15));
 deadpan    = str2double(extractBetween(Data, 17, 20));

end