function [r,fObj] = locationsEC(B, R, gamma, dr)
% Given:
% - B: number of PBs;
% - R: radius of the cservice area;
% - gamma: path loss exponent;
% - dr: Algorithm's step size;
%
% it provides the objective function fObj (as described at the end) to further find
% the optimum r.
    
    %% pre-allocate memory
    r = (0:dr:R); 
    d = zeros(B,numel(r));
    
    %% compute the incident power at the minima
    if mod(B,2) == 0
        for i=1 : B/2
            d(i,:) = sqrt(R.^2+r.^2-2*R.*r.*cos(pi./B+(i-1).*2*pi./B));
            d(B+1-i,:) = d(i,:);
        end
    else
        d((B+1)/2,:) = R+r;
  
        for i=1 : (B-1)/2
            d(i,:) = sqrt(R.^2+r.^2-2*R.*r.*cos(pi./B+(i-1).*2*pi./B));
            d(B+1-i,:) = d(i,:);
        end
    end
        
    %% fObj =  minimum EC apporach(dB) - one centered PB(dB)
    fObj = 10.*log10(min(sum(d.^(-gamma)),B.*r.^(-gamma)))-10.*log10(B.*R.^(-gamma));
end