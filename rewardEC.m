function [Ee, Ec] = rewardEC(B, R, r, gamma)
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
    
    %% compute the incident power
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
    
    Ee = 10.*log10(sum(d.^(-gamma)));
    Ec = 10.*log10(B.*r.^(-gamma));
end