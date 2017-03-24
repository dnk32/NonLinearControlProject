function dq = diffVehiModel(t,q)

th = q(1);
x = q(2);
y = q(3);
vx = q(4);
w = q(5);
F = q(6);

z1 = x;
z2 = vx*cos(th);
z3 = -vx*w*sin(th) + F*cos(th);

z4 = y;
z5 = vx*sin(th);
z6 = vx*w*cos(th) + F*sin(th);

Z = [z1, z2, z3, z4, z5, z6]';

%% FBL matrices
rho = [cos(th) -vx*sin(th); sin(th) vx*cos(th)];
alpha = [-vx*w^2*cos(th) - 2*F*w*sin(th); -vx*w^2*sin(th) + 2*F*w*cos(th)];
%% Reference signal
tau = 10;
xc = 50*cos(2*pi*t/tau) + 25*sin(pi*t/tau);
yc = 50*sin(pi*t/tau)-25*cos(pi*t/tau) + 25;

xc1 = -50*sin(2*pi*t/tau)*(2*pi/tau) + 25*cos(pi*t/tau)*(pi/tau);
xc2 = -50*cos(2*pi*t/tau)*(2*pi/tau)^2 - 25*sin(pi*t/tau)*(pi/tau)^2;
xc3 = 50*sin(2*pi*t/tau)*(2*pi/tau)^3 - 25*cos(pi*t/tau)*(pi/tau)^3;

yc1 = 50*cos(pi*t/tau)*(pi/tau) + 25*sin(pi*t/tau)*(pi/tau);
yc2 = -50*sin(pi*t/tau)*(pi/tau)^2 + 25*cos(pi*t/tau)*(pi/tau)^2;
yc3 = -50*cos(pi*t/tau)*(pi/tau)^3 - 25*sin(pi*t/tau)*(pi/tau)^3;

R = [xc, xc1, xc2, yc, yc1, yc2]';
%% Error Signals
E = Z-R;
K = [6 11 6 0 0 0; 0 0 0 6 11 6];
%% Input Signals
V = -K*E + [xc3; yc3];
Inputs = inv(rho)*(V - alpha);
Fz = Inputs(1);
T = Inputs(2);
%%

dth = w;
dx = vx*cos(th);
dy = vx*sin(th);
dvx = F;
dw = T;
dF = Fz;

dq = [dth, dx, dy, dvx, dw, dF]';