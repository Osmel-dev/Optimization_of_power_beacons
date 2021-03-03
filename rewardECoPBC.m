function [Ee2, Ex] = rewardECoPBC(B, R, r, gamma)
% Given:
% - B: number of PBs;
% - R: radius of the cservice area;
% - r: distance of the PBs to the center;
% - gamma: path loss exponent;
%
% it computes the average incident RF power at:
% - Ex: the contribution in a sensor equidistant to the centerand two
% adjacent PBs;
% - Ee2: the contribution at the circle's edge.

    %% allocate memory
    d = zeros(B,numel(r)); % distance to the edge
    x = zeros(B,numel(r)); % distance to the centered PB and two adjacent PBs
    
    %% compute the incident power
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
    
    Ee2 = 10.*log10(sum(d.^(-gamma)));
    Ex = 10.*log10(sum(x.^(-gamma)));
end