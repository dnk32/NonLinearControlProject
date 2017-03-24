function dq = diffVehiModel_2(t,q, params)
cntrType = params(1);

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

%% control input computation
K = [1 2 1 0 0 0; 0 0 0 1 2 1];
% K = [0 1 1 0 0 0; 0 0 0 0 1 1];
A = [0 1 0 0 0 0;...
     0 0 1 0 0 0;...
     0 0 0 0 0 0;...
     0 0 0 0 1 0;...
     0 0 0 0 0 1;...
     0 0 0 0 0 0];
 
S = rho'*K*Z;
H = ( K*A*Z + alpha )'*K*Z;
 
if cntrType==4
    [T, Fz] = getControls_II(K, A,  Z, rho, alpha, params);
elseif cntrType==3
    [T, Fz] = getControlsReaching(K, A,  Z, rho, alpha, params);
else
    [T, Fz] = getControls(H, S, F, params);
end

if (t-floor(t))<0.0001
    t
end
Vdot = [K*A*Z + alpha]'*K*Z + [Fz T]*S;
V = (K*Z)'*K*Z;
% t
if Vdot >0
    disp('anomaly reached');
    V = (K*Z)'*K*Z
end
%%

dth = w;
dx = vx*cos(th);
dy = vx*sin(th);
dvx = F;
dw = T;
dF = Fz;

dq = [dth, dx, dy, dvx, dw, dF]';