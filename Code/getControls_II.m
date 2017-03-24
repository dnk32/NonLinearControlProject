function [T, Fz] = getControls_II(K, A, Z, rho, alpha ,params)
cntrType = params(1);
FzLim = params(2);
TLim = params(3);
FLim = FzLim;

U1 = inv(rho)*(-K*A*Z - alpha);
U2 = -sign(rho'*K*Z).*[FzLim/2; TLim/2];

U = U1+U2;
Fz = U(1);
if abs(U(2)) < TLim
    T = U(2);
else
    T = sign(U(2))*TLim;
end