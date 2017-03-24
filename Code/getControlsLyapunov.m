function [T, Fz] = getControlsLyapunov(K, A, Z, rho, alpha ,params)

FzLim = params(2);
TLim = params(3);
FLim = FzLim;

% the switching limits for the inputs
% Larger limits ==> quicker appraoch to sliding surface, but large
% magnitude input switchin across the surface. This will lead to high power
% transient signals
% Smaller limits ==> longer stabilization times to the sliding surface
FzSwitchLim = FzLim;
TSwitchLim = TLim;

U1 = inv(rho)*(-K*A*Z - alpha);
U2 = -sign(rho'*K*Z).*[FzSwitchLim; TSwitchLim];

U = U1+U2;
Fz = U(1);
if abs(U(2)) < TLim
    T = U(2);
else
    T = sign(U(2))*TLim;
end