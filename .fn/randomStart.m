function [msv_start, goal] = randomStart(test)
% randomStart : Setup start conditions for msv rl

    if ~exist("test", "var")
        test = 0;
    end

    if test == 0
        yaw = rand*180 - 90;  % yaw = 43;
        msv_start = [0 ; 0 ; deg2rad(yaw)] ; 
        goal = [ (rand*10) ; (rand*20 - 10) ]; 
        goal = round(goal,2);
        goal = [goal ; msv_start(3)];
        goal = reshape(goal,[3,1]);
    else
        msv_start   = [0 ; 0 ; 0];
        goal        = [5 ; 0 ; 0];
    end


end