function [Z, Fz, T] = findInputs(q,params)

disp('computing input profile using the statue evolution')
%%
cntrType = params(1);

% states
th = q(:,1);
x = q(:,2);
y = q(:,3);
vx = q(:,4);
w = q(:,5);
F = q(:,6);

% FBL states
z1 = x;
z2 = vx.*cos(th);
z3 = -vx.*w.*sin(th) + F.*cos(th);

z4 = y;
z5 = vx.*sin(th);
z6 = vx.*w.*cos(th) + F.*sin(th);

Z = [z1, z2, z3, z4, z5, z6];

% sliding surface S = KZ
K = [1 2 1 0 0 0; 0 0 0 1 2 1];

% state matrix of FBL
A = [0 1 0 0 0 0;...
     0 0 1 0 0 0;...
     0 0 0 0 0 0;...
     0 0 0 0 1 0;...
     0 0 0 0 0 1;...
     0 0 0 0 0 0];
 
% computation of inputs using the state evolution
T = zeros(size(q,1),1);
Fz = zeros(size(q,1),1);
for i=1:size(q,1)
    rho = [cos(th(i)) -vx(i)*sin(th(i)); sin(th(i)) vx(i)*cos(th(i))];
    alpha = [-vx(i)*w(i)^2*cos(th(i)) - 2*F(i)*w(i)*sin(th(i)); -vx(i)*w(i)^2*sin(th(i)) + 2*F(i)*w(i)*cos(th(i))];
    
    S = rho'*K*Z(i,:)';
    H = ( K*A*Z(i,:)' + alpha )'*K*Z(i,:)';
    if cntrType==1
        [T(i), Fz(i)] = getControlsLyapunov(K, A,  Z(i,:)', rho, alpha, params);
    elseif cntrType==2
        [T(i), Fz(i)] = getControlsReaching(K, A,  Z(i,:)', rho, alpha, params);
    end
    Vdot = [K*A*Z(i,:)' + alpha]'*K*Z(i,:)' + [Fz(i) T(i)]*S;
    s = K*Z(i,:)';
    V = 1/2*s'*s;
end