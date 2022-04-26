function [y, pipe_percentage] = ir2y(ir)
%% Converts IR reading from the top to the distance in meters from the bottom
% Inputs:
%  ~ ir: the IR reading from time of flight sensor
% Outputs:
%  ~ y: the distance in [m] from the bottom to the ball
%  ~ pipe_percentage: on a scale of 0 (bottom of pipe) to 1 (top of pipe)
%  where is the ball
%
% Created by:  Kyle Naddeo 2/2/2022
% Modified by: YOUR NAME and DATE

%% Parameters
ir_bottom =   900;
ir_top    =   26;
y_top     = 0.9144; % Ball at top of the pipe [m]

%% Bound the IR reading and send error message
if ir < ir_top
    ir = ir_top;
elseif ir > ir_bottom
    ir = ir_bottom;
end
%% Set
pipe_percentage = 1 - (ir - ir_top)/(ir_bottom - ir_top);
y = pipe_percentage * y_top;

