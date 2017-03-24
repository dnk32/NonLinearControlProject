function [T, Fz] = getControls(H,S,F,params)
cntrType = params(1);
FzLim = params(2);
TLim = params(3);
FLim = FzLim;

% if cntrType==1
%     % control for when inputs are not limited
%    
%     Fz = -2*abs( H )/S(1);
%     T = -2*abs( H )/S(2);
% else
%     % control for limited control
%     Fzt = -2*abs( H )/S(1);
%     if abs(F) < FLim
%         Fz = Fzt;
%     else
%         Fz = 0;
%     end
% %     elseif F >= FLim
% %         Fz = (Fzt<0)*Fzt;
% %     else
% %         Fz = (Fzt>0)*Fzt;
% %     end
%         
% %     Fz = -sign( S(1) )*FzLim;
%     T = -sign( S(2) )*TLim;
% end

if cntrType==1
    % control for when inputs are not limited
   
    Fz = -abs( H )*sign( S(1) );
    T = -abs( H )*sign( S(2) );
else
    % control for limited control
%     Fzt = -2*abs( H )*sign( S(1) );
%     if abs(F) < FLim
%         Fz = Fzt;
%     else
%         Fz = 0;
%     end
%     elseif F >= FLim
%         Fz = (Fzt<0)*Fzt;
%     else
%         Fz = (Fzt>0)*Fzt;
%     end
        
    Fz = -sign( S(1) )*FzLim;
    T = -sign( S(2) )*TLim;
end