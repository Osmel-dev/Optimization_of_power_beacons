% This is a simulation demo file where you can try the Ode-PoBes algorithm
B = 15;
R = 100;
gamma = 3;
dr = 1;

[xyN, Emin, rOpt] = OdePoBes(B, gamma, R, dr);

figure(1)
theta = linspace(0, 2*pi, 100);
plot(R*cos(theta), R*sin(theta), '-b', 'LineWidth', 2); hold on
plot(xyN(1:B), xyN(B+1:end), 'xk', 'LineWidth', 2); hold off

axis equal