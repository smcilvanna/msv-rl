cd("C:\Users\14244039\OneDrive - Queen's University Belfast\Documents\MATLAB\rl\msv_rl_ctrl");
disp("This section prevents the [RUN] button working - run by section ")
return
disp("This section prevents the [RUN] button working - run by section ")
%% MSV PID-RL - Initial Setup

open("msv_rl.slx");
addpath("./.fn/");
modeSel("pid-rl");
map = createMap();
test = 1;
[msv_start, goal] = randomStart(test); % set test =0 for random start, =1 for fixed
kpid = [ 2 ; 0 ; 0 ];


%% 

close all;
allData = [];

kp = 0 :0.5: 30 ;   kp(1) = 0.2;
ki = 0 :0.5: 30 ;   ki(1) = 0.2;
kd = 0 :0.1: 5  ;   kd(1) = 0.05;

runs = size(kp,2)*size(ki,2)*size(kd,2);

disp("Total Runs = " + runs)
disp("Starting...")
pause(2)

set_param("msv_rl","FastRestart","on");

for p = 1:size(kp,2)
for i = 1:size(ki,2)
for d = 1:size(kd,2)

    kpid    = [kp(p) ; ki(i) ; kd(d)];
    out     = sim("msv_rl.slx");
    allData = [allData ; out];

    disp(kpid);

end
end
end

set_param("msv_rl","FastRestart","off");
clearvars kp ki kd p i d runs




























%% SETUP ENVIRONMENT

% observations
% error         [ ex    ey      eyaw]
% error_dot     [ eex   eey     eeyaw]
% velocity      [ vx    vy      vyaw]

obsInfo = rlNumericSpec([9 1]);
obsInfo.Name = "Observations";

% actions
% thrusters     [surge sway]


actInfo             = rlNumericSpec([2 1]);
actInfo.Name        = "Actions";
actInfo.LowerLimit  = -100  ;
actInfo.UpperLimit  =  100    ;

% setup simulation environment for RL
env     = rlSimulinkEnv( "msv_rl", "msv_rl/Controller/RLagent", obsInfo, actInfo ) ;

%env.ResetFcn = @rlReset;



%% SETUP AGENT
    
% agent = rlDDPGAgent(obsInfo, actInfo);
% 
% agent.AgentOptions.SampleTime = 10;
% agent.UseExplorationPolicy = true;
% agent.AgentOptions.DiscountFactor = 0.95;

%% TD3 agent

agent = rlTD3Agent(obsInfo,actInfo)
%agent.AgentOptions.SampleTime = 10;
agent.UseExplorationPolicy = true;
%agent.AgentOptions.DiscountFactor = 0.80;

%% TRAINING


opts                        = rlTrainingOptions;
opts.Verbose                = true;
opts.MaxEpisodes            = 20000;
opts.StopTrainingCriteria   = "EpisodeCount";
opts.StopTrainingValue      = opts.MaxEpisodes;
opts.MaxStepsPerEpisode     = 1;
opts.StopOnError            = 'off';

info    = train(agent, env, opts);








%% Block names - for config

x.rl    = 'msv_rl/Controller/captainRL'
x.pid   = 'msv_rl/Controller/captainPID'
x.pidrl = 'msv_rl/Controller/captainPID-RL'


%% CONFIGURE - PID
set_param('msv_rl/Controller/captainPID','Commented','off');
set_param('msv_rl/Controller/captainRL','Commented','on');
set_param('msv_rl/Controller/captainPID-RL','Commented','on');
set_param('msv_rl/Controller/sw1', 'sw', '0');
set_param('msv_rl/Controller/sw2', 'sw', '1');


%% CONFIGURE - RL
set_param('msv_rl/Controller/captainPID','Commented','on');
set_param('msv_rl/Controller/captainRL','Commented','off');
set_param('msv_rl/Controller/captainPID-RL','Commented','on');
set_param('msv_rl/Controller/sw1', 'sw', '1');


%% CONFIGURE - PID-RL
set_param('msv_rl/Controller/captainPID','Commented','on');
set_param('msv_rl/Controller/captainRL','Commented','on');
set_param('msv_rl/Controller/captainPID-RL','Commented','off');
set_param('msv_rl/Controller/sw1', 'sw', '0');
set_param('msv_rl/Controller/sw2', 'sw', '0');











%% Reward Functions

close all
% Seperation dot reward


x = -2.0 :0.01: 2.0;
y = x;   % <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
y(y>1)=1;
y(y<-1)=-1;
figure(Visible="on");
ax1 = gca;
plot(x,y, LineWidth=2, DisplayName="Seperation Reward", Color='green');
title("Tracking Reward")
xlabel("ROV - Trajectory Seperation (m)")
ylabel("Reward (step)")

% figure(Visible="off");
% ax2 = gca;
% x = 0:1:5000;
% y = 1 ./ (1 + exp(-0.01 * (x - 3000))); % <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
% plot(x,y, LineWidth=2, DisplayName="Control Penalty", Color='red');
% title("Control Penalty");
% xlabel("Control Value")
% ylabel("Penalty (step)")


% fig3 = figure();
% tcl=tiledlayout(2,1);
% ax1.Parent=tcl;
% ax1.Layout.Tile=1;
% ax2.Parent=tcl;
% ax2.Layout.Tile=2;

% title(tcl, "Parameter Training Reward Functions");
% subtitle(tcl, "Reward per timestep (10ms)")





















