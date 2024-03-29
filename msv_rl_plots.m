%% Plots

load("/home/sm/matlab/.data/msv-rl/msvrlpid1.mat");

%% Plot alldata position

if exist("plot.gif","file")
    input("plot.gif file already exists, Ctrl + c to exit, ENTER to overwrite")
    delete("plot.gif")
end

n = 20 ; % print top n reward results


rewardTable = sortReward(allData);

for i = 1:n
    out = allData(rewardTable(i,1));
    fig = plotPosition(out,0,rewardTable(i,2));   
    exportgraphics(fig, "plot.gif", Append=true);
    disp(i);
end







%% Position Plot (moved to fn)
close all;
clk     = squeeze(out.tout);
states  = squeeze(out.states.Data)';
x = states(:,1); y = states(:,2); z = states(:,3);

figure(1);
ax1 = gca;

plot(x,y, LineWidth=2, DisplayName="msv trajectory")
hold on
scatter(goal(1), goal(2), 100, Marker="x", LineWidth=4, DisplayName="Goal");
xlabel("x(m)");
ylabel("y(m)");
axis("equal")

figure(2);
ax2 = gca;

plot(clk, z, DisplayName="msv yaw", Color=[0.5 0.5 0.1], LineWidth=2);
xlabel("Time (s)")
legend



fig3 = figure();
tcl=tiledlayout(2,1);
ax1.Parent=tcl;
ax1.Layout.Tile=1;
legend
ax2.Parent=tcl;
ax2.Layout.Tile=2;
legend
close(1)
close(2)

%% Velocity Plot


close all;

states = squeeze(out.states.Data)';
x = states(:,1); y = states(:,2); z = states(:,3);

clk = squeeze(out.tout);
dt = clk(2) - clk(1); % assuming fixed sim time - need to update if variable 

% plot3(x,y,z, Color=[0 1 0]);

% x - velocity
dx = zeros(size(x));
for ix = 2:(size(x,1))
    dx(ix) = x(ix) - x(ix-1);
end

dx_dt = dx / dt;

% y - velocity
dy = zeros(size(y));
for iy = 2:(size(y,1))
    dy(iy) = y(iy) - y(iy-1);
end

dy_dt = dy / dt;

% z - velocity
dz = zeros(size(z));
for iz = 2:(size(z,1))
    dz(iz) = z(iz) - z(iz-1);
end

dz_dt = dz / dt;

% total velocity
vel = zeros(size(z));
for iv = 2:(size(vel,1))
    vel(iv) = norm([dx_dt(iv), dy_dt(iv), dz_dt(iv) ]);
end


fig = figure(Visible="off");
ax1 = gca();
plot(clk,dx_dt,LineWidth=2, DisplayName="x velocity");
hold on;
plot(clk,dy_dt,LineWidth=2, DisplayName="y velocity");
plot(clk,dz_dt,LineWidth=2, DisplayName="z velocity");
legend();
title("Velocity Components");
xlabel("Time (seconds)");
ylabel("Velocity m/s");

fig2 = figure(Visible="off");
ax2 = gca();
plot(clk, vel, LineWidth=2, DisplayName="ROV Velocity", Color=[0 0 0])
hold on;
yline( 1, ':r', DisplayName="max velocity", LineWidth=2);
yline(-1, ':b', DisplayName="min velocity", LineWidth=2)
title("Velocity Magnitude");
legend();
xlabel("Time (seconds)");
ylabel("Velocity m/s");

fig3 = figure();
tcl=tiledlayout(2,1);
ax1.Parent=tcl;
ax1.Layout.Tile=1;
ax2.Parent=tcl;
ax2.Layout.Tile=2;

clearvars -except out* map

%% Control Plot
close all

u = squeeze(out.ctrl.Data)
clk = squeeze(out.tout);

headings = ["Surge", "Sway", "Yaw"]';


t = tiledlayout(1,3,'TileSpacing','Compact')

hold on;

for i = 1:3
    nexttile();
    plot(clk,u(:,i), LineWidth=2);
    title(headings(i));

end