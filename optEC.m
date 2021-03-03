function rOptEC = optEC(B, R, gamma, dr)
% Given:
% - B: number of PBs;
% - R: radius of the cservice area;
% - gamma: path loss exponent
% - dr: Algorithm's step size;
%
% it computes the optimum PBs' distance to the center rOptEC.
    
    %% pre-allocate memory
    rOptEC = zeros(1,numel(B));
    
    %% main loop
    for i = B
        [r,g] = locationsEC(i, R, gamma, dr);
        [~,ix] = max(g);
        rOptEC(i+1-B(1)) = r(ix);
    end
end