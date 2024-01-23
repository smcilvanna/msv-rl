function [map] = createMap(mlen)
% randomStart : Setup start conditions for msv rl

    if ~exist("mlen","var")
        mlen = 20;                              % define the square edge length of map
    end
        
    map = binaryOccupancyMap(mlen,mlen,100);    % create mlen x mlen map with a resolution of 100 steps per m
    move(map,[-mlen/2 -mlen/2]);                % offset the map so 0,0 is in the center
    
    % Uncomment these commands to add a feature in the middle of the map
    % setOccupancy(map, [0 0], 1 );
    % inflate(map,0.2);

end