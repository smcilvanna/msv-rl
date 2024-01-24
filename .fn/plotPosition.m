function fig3 = plotPosition(out, visible)

if ~exist("visible","var")
    visible = 0;
end

kpid = out.kpid.Data;
ttxt = "kp= " + kpid(1) + " |  ki= " + kpid(2) + " |  kd= " + kpid(3) ;


goal = out.goal.Data;

clk     = squeeze(out.tout);
states  = squeeze(out.states.Data)';
x = states(:,1); y = states(:,2); z = states(:,3);

figure(Visible="off");
ax1 = gca;

plot(x,y, LineWidth=2, DisplayName="msv trajectory")
hold on
scatter(goal(1), goal(2), 100, Marker="x", LineWidth=4, DisplayName="Goal");
xlabel("x(m)");
ylabel("y(m)");
axis("equal")

figure(Visible="off");
ax2 = gca;

plot(clk, z, DisplayName="msv yaw", Color=[0.5 0.5 0.1], LineWidth=2);
xlabel("Time (s)")
legend


if visible == 0
    fig3 = figure(Visible='off');
else
    fig3 = figure(Visible='on');
end

tcl=tiledlayout(2,1);
ax1.Parent=tcl;
ax1.Layout.Tile=1;
legend
ax2.Parent=tcl;
ax2.Layout.Tile=2;
legend
subtitle(ttxt);

end

