function [T, Fz] = getControlsReaching(K, A,  Z, rho, alpha, params)
FzLim = params(2);
TLim = params(3);

S = K*Z;
Q = [1 0; 0 1];
kS = [1 0 ;0 1];

U = inv(rho)*( -Q*sign(S) - kS*S - K*A*Z - alpha );
if abs(U(1)) < FzLim
    Fz = U(1);
else
    Fz = sign(U(1))*FzLim;
end
if abs(U(2)) < TLim
    T = U(2);
else
    T = sign(U(2))*TLim;
end
% Fz = U(1);
% T = U(2);
