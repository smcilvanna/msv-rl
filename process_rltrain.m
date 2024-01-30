return
%%
close all
x   = info.EpisodeIndex;
y1  = info.EpisodeReward;
y2  = info.AverageReward;

figure(1); ax1 = gca;
plot(x,y1, Color=[0 0 1], DisplayName="Episode Reward", LineWidth=2);
hold on
plot(x,y2, Color=[1 0.5 0], DisplayName="Average Reward", LineWidth=1.5);
xlabel("Episode Number");
ylabel("Reward Value");
title("Training Results");
legend();


%% Get tested parameters


sz = size(info.SimulationInfo,1)

% Get the rewards and sort for best 10
allData = info.SimulationInfo;
rewardTable = sortReward(allData);
rewardTable = rewardTable(1:10,:);


allParms = [];

for i = 1:sz
    %allParms = [allParms ; {squeeze(info.SimulationInfo(i).kpid.Data)'} ];
    allParms = [allParms ; squeeze(info.SimulationInfo(i).kpid.Data)' ];
    disp(i);
end

figure(2); ax2 =gca;
scatter(allParms(:,1), allParms(:,2), 2, "filled");
hold on;
xlabel("kp");
ylabel("ki");
title("Training Coverage");

for ii = 1:size(rewardTable,1)

    parms = info.SimulationInfo(rewardTable(ii,1)).kpid.Data;


end

%%
fig3 = figure(3);
tcl=tiledlayout(2,1);
ax1.Parent=tcl;
ax1.Layout.Tile=1;
ax2.Parent=tcl;
ax2.Layout.Tile=2;

close(figure(1));
close(figure(2));
% hold on;
% 
% for ii = 1:sz
%     data = allParms{i};
%     scatter3( data(:,1), data(:,2), ii, 2, "filled"); % plot each episode on a seperate z layer
%     pause(1);
% end
%     
% xlabel("kp");
% ylabel("ki");
% zlabel("Episode");
% title("Training Coverage");



clearvars i sz



%%






%%
ep = allParms{3}

kp = ep(:,1);
ki = ep(:,2);
id = [1:1:size(ep,1)]';

figure