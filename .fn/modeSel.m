function modeSel(mode)
%modeSel - Select Configuration for simulink

% % Block names - for config
% 
% x.rl    = 'msv_rl/Controller/captainRL'
% x.pid   = 'msv_rl/Controller/captainPID'
% x.pidrl = 'msv_rl/Controller/captainPID-RL'

    if ~exist("mode","var")
        mode = 0;
    end

    mode = lower(string(mode));

    if (mode == "0" || mode =="pid")

        % CONFIGURE - PID
        set_param('msv_rl/Controller/captainPID','Commented','off');
        set_param('msv_rl/Controller/captainRL','Commented','on');
        set_param('msv_rl/Controller/captainPID-RL','Commented','on');
        set_param('msv_rl/Controller/sw1', 'sw', '0');
        set_param('msv_rl/Controller/sw2', 'sw', '1');
    
    elseif (mode == "1" || mode =="rl")
        % CONFIGURE - RL
        set_param('msv_rl/Controller/captainPID','Commented','on');
        set_param('msv_rl/Controller/captainRL','Commented','off');
        set_param('msv_rl/Controller/captainPID-RL','Commented','on');
        set_param('msv_rl/Controller/sw1', 'sw', '1');
    
    elseif (mode == "2" || mode =="pid-rl")
    
        % CONFIGURE - PID-RL
        set_param('msv_rl/Controller/captainPID','Commented','on');
        set_param('msv_rl/Controller/captainRL','Commented','on');
        set_param('msv_rl/Controller/captainPID-RL','Commented','off');
        set_param('msv_rl/Controller/sw1', 'sw', '0');
        set_param('msv_rl/Controller/sw2', 'sw', '0');

    else
        disp("Mode not recognised, enter 0 (PID), 2 (RL) or 3 (PID-RL)")

    end


end

