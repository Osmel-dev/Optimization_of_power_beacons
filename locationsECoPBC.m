function [r,fObj] = locationsECoPBC(B, R, gamma, dr)
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
    x = zeros(B,numel(r));
    
    %% compute the incident power at the minima
    if mod(B-1,2) == 0
            d(B,:) = R;
            x(B,:) = r./(2.*cos(pi./(B-1)));
        for i=1 : (B-1)/2
            d(i,:) = sqrt(R.^2+r.^2-2*R.*r.*cos(pi./(B-1)+(i-1).*2*pi./(B-1)));
            d(B-i,:) = d(i,:);
            x(i,:) = sqrt(x(B,:).^2+r.^2-2*x(B,:).*r.*cos(pi./(B-1)+(i-1).*2*pi./(B-1)));
            x(B-i,:) = x(i,:);
        end
    else
        d(B,:) = R;
        d(B/2,:) = R+r;
        x(B,:) = r./(2.*cos(pi./(B-1)));
        x(B/2,:) = r+r./(2.*cos(pi./(B-1)));
        for i=1 : (B-2)/2
            d(i,:) = sqrt(R.^2+r.^2-2*R.*r.*cos(pi./(B-1)+(i-1).*2*pi./(B-1)));
            d(B-i,:) = d(i,:);
            x(i,:) = sqrt(x(B,:).^2+r.^2-2*x(B,:).*r.*cos(pi./(B-1)+(i-1).*2*pi./(B-1)));
            x(B-i,:) = x(i,:);
        end
    end
    
    %% fObj = minimum EC with one PB centered apporach(dB) - one centered PB(dB)
    fObj = 10.*log10(min(sum(d.^(-gamma)),sum(x.^(-gamma))))-10.*log10(B.*R.^(-gamma));  
end