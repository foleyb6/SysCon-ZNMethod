% A MATLAB script to control Rowans Systems & Control Floating Ball 
% Apparatus designed by Mario Leone, Karl Dyer and Michelle Frolio. 
% The current control system is a PID controller.
%
% Created by Kyle Naddeo, Mon Jan 3 11:19:49 EST 
% Modified by YOUR NAME AND DATE

%% Start fresh
close all; clc; clear device;

%% Connect to device
% device = open serial communication in the proper COM port
device = serialport('COM4', 19200);
%% Parameters
target      = 0.5;   % Desired height of the ball [m]
sample_rate = 0.0001;  % Amount of time between controll actions [s]

%% Give an initial burst to lift ball and keep in air
set_pwm(device,0000); % Initial burst to pick up ball
pause(1) % Wait 0.1 seconds5
set_pwm(device,4000); % Set to lesser value to level out somewhere in
% the pipe

%% Initialize variables
action      = 500; % Same value of last set_pwm   
error       = 0;
error_sum   = 0;
error_prev  = 0;
%% Feedback loop
while true
    %% Read current height
    [distance, ~, ~, ~] = read_data(device);
    y = ir2y(distance); % Convert from IR reading to distance from bottom [m]
    
    %% Calcu5late errors for PID controller
    error_prev = error;
    error      = target - y;      % P
    error_sum  = error + error_sum; % I
    
    error_div = (error - error_prev)/sample_rate; % D
   
    %% Control
    Kp = 27000;
    Ki = 27000;
    Kd = 6750;
    input = Kp * error + Ki * error_sum + Kd * error_div;
    set_pwm(device, input); % Implement action
    % Wait for next sample
    pause(sample_rate)
end

