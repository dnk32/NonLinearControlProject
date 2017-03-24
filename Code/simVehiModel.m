% clear all;
close all;
clc;
%% params
cntrType = 4; % 1 - control inputs not limited, 2 - limited control, 3 - reaching control, 4- better control structure
% cntrType 4 gives the best results.

FxLim = 1;
TLim = 4;

params = [cntrType, FxLim, TLim];
%% initial conditions
x0 = -10;
y0 = -10;
th0 = 0;
vx0 = 1;
w0 = 0;
F0 = 0;

initConds = [th0, x0, y0, vx0, w0, F0];
%% simulate
odefun = @(t,q) diffVehiModel_2(t,q,params);
[t,q] = ode45(odefun, [0 14], initConds);

th = q(:,1);
x = q(:,2);
y = q(:,3);
vx = q(:,4);
w = q(:,5);
F = q(:,6);

%% plot
[Z, Fz, T] = findInputs(q,params);
figure
plot(x,y)
hold on
h1 = plot(x(1),y(1),'rs');
h2 = plot(x(end),y(end),'bs');
xlim([0 25])
ylim([0 11])
xlabel('x(m)','fontweight','bold','fontsize',12)
ylabel('y(m)','fontweight','bold','fontsize',12)
legend([h1 h2],'start','ened')

figure
subplot(511)
plot(t,x)
title('x')
subplot(512)
plot(t,y)
title('y')
subplot(513)
plot(t,th)
title('\theta')
subplot(514)
plot(t,vx)
title('v_x')
subplot(515)
plot(t,w)
title('\omega')


figure
subplot(311)
plot(t,F)
xlabel('t','fontweight','bold','fontsize',10)
ylabel('F','fontweight','bold','fontsize',10)
title('Force Input (F)','fontweight','bold','fontsize',12)
subplot(312)
plot(t,Fz)
xlabel('t','fontweight','bold','fontsize',10)
ylabel('u','fontweight','bold','fontsize',10)
title('Dynamically extended Input (u)','fontweight','bold','fontsize',12)
subplot(313)
plot(t,T)
xlabel('t','fontweight','bold','fontsize',10)
ylabel('T','fontweight','bold','fontsize',10)
title('Tourque Input (T)','fontweight','bold','fontsize',12)

figure
title('z')
subplot(611)
plot(t,Z(:,1))
title('z1')
subplot(612)
plot(t,Z(:,2))
title('z2')
subplot(613)
plot(t,Z(:,3))
title('z3')
subplot(614)
plot(t,Z(:,4))
title('z4')
subplot(615)
plot(t,Z(:,5))
title('z5')
subplot(616)
plot(t,Z(:,6))
title('z6')

figure
K = [1 2 1 0 0 0; 0 0 0 1 2 1];
% K = [0 1 1 0 0 0; 0 0 0 0 1 1];
s = K*Z';
V = sum(s.^2,1)/2;
plot(t,V)
xlabel('time','fontweight','bold','fontsize',12)
ylabel('V','fontweight','bold','fontsize',12)
