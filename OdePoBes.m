function [xyN, Emin, rOpt] = OdePoBes(B, gamma, R, dr)
% This function computes the optimum positions of B (can be a range e.g., B = 1:5) PBs given:
% - gamma: path loss exponent;
% - R: radius of the service area;
% - dr: Algorithm's step size. 

% The function outputs:
% - the PBs' position in the array xyN = [x_1 x_2 ... x_B y_1 y_2 y_B];
% - the minimum average incident RF power Emin;
% - the optimum distance to the center rOpt (for the distributed PBs). 
    
    %% Equally-far-from-center with on PB centered (optECoPBC) strategy.
    rOptECoPBC = optECoPBC(B, R, gamma, dr); % finds optimum distance r
    
    Ee2 = zeros(1, numel(B)); % pre-allocate memory
    Ex = zeros(1, numel(B)); % pre-allocate memory
    
    for ii = 1 : numel(B)
        [Ee2(ii), Ex(ii)] = rewardECoPBC(B(ii), R, rOptECoPBC(ii), gamma);
    end
    
    %% Equally-far-from-center (EC) strategy 
    rOptEC = optEC(B, R, gamma, dr); % finds optimum distance r
    
    Ee = zeros(1, numel(B)); % pre-allocate memory
    Ec = zeros(1, numel(B)); % pre-allocate memory
    
    for ii = 1 : numel(B)
        [Ee(ii), Ec(ii)] = rewardEC(B(ii), R, rOptEC(ii), gamma);
    end
    
    %% Find the optimum positions
    xyN = [];
    rOpt = zeros(size(B'));
    Emin = zeros(size(B'));
    
    for ii = B
        index = ii-B(1)+1;
        if (min(Ee(index), Ec(index)) > min(Ee2(index), Ex(index)))
            theta = 2*pi/ii;
            Emin(index) = min(Ee(index), Ec(index));
            xyN = [xyN rOptEC(index)*cos(theta*(0:ii-1)) rOptEC(index)*sin(theta*(0:ii-1))];    
            rOpt(index) = rOptEC(index);
        else
            theta = 2*pi/(ii-1);
            Emin(index) = min(Ee2(index), Ex(index));
            xyN = [xyN 0 rOptECoPBC(index)*cos(theta*(0:ii-2)) 0 rOptECoPBC(index)*sin(theta*(0:ii-2))];
            rOpt(index) = rOptECoPBC(index);
        end
    end
end

