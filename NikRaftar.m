clear
clc
close all
global numGa denGa numGb denGb numGc denGc numGd denGd...
       numGe denGe numGf denGf Kp_pd Ki_pd Kd_pd...
       Kp_igv Ki_igv Kd_igv NoiseF NoiseIGV
answer = questdlg('Which one is selected?','Selection','Without Noise','With Noise','Without Noise')
switch answer
case  'With Noise'
%   answer = 'With Noise' 
    NoiseF=1;
    NoiseIGV=1;
    case 'Without Noise'   
      NoiseF=0;
      NoiseIGV=0;
end
%%
Kp_pd=1; 
Ki_pd=.03; 
Kd_pd=.04; 
%
Kp_igv=1; 
Ki_igv=.02; 
Kd_igv=.05;
%%
num1=[.3827,.8935,.2562];
den1=[1,1.3331,.2015];
num2=[-.212,-.4496,-.05068];
den2=[1,1.3331,.2015];
num3=[0,1];
den3=[18.5,0];
num4=[21.98,207.6,327.2];
den4=[1,3.266,.9384];
num5=[.7975,.8849,-1.42];
den5=[1,3.266,.9384];
num6=[79.19,344.5,372.3];
den6=[1,3.266,.9384];
num7=[-119,312.3,-148.6];
den7=[1,3.266,.9384];
%%
G1=tf(num1,den1);
G2=tf(num2,den2);
G3=tf(num3,den3);
G4=tf(num4,den4);
G5=tf(num5,den5);
G6=tf(num6,den6);
G7=tf(num7,den7);
%%
Ga=-G3/(1-G2*G3);
Gb=G1*G3/(1-G2*G3);
Gc=-G2*G3/(1-G2*G3);
Gd=G1/(1-G2*G3);
Ge=-G3*G1/(1-G2*G3);
Gf=(G1*G3*G4/(1-G2*G3))+G7;
%% numGa denGa
[numGa,denGa]=tfdata(Ga);
numGa=cell2mat(numGa);
denGa=cell2mat(denGa);
[numGb,denGb]=tfdata(Gb);
numGb=cell2mat(numGb);
denGb=cell2mat(denGb);
[numGc,denGc]=tfdata(Gc);
numGc=cell2mat(numGc);
denGc=cell2mat(denGc);
[numGd,denGd]=tfdata(Gd);
numGd=cell2mat(numGd);
denGd=cell2mat(denGd);
[numGe,denGe]=tfdata(Ge);
numGe=cell2mat(numGe);
denGe=cell2mat(denGe);
[numGf,denGf]=tfdata(Gf);
numGf=cell2mat(numGf);
denGf=cell2mat(denGf);
%% simulation
sim('turbine')
%% result
Data1=F;
Data2=F_control;
figure(1)
plot(Data1,'b','linewidth',2)
hold on
plot(Data2,'r:','linewidth',2)
title('Fuel Flow')
xlabel('time - s ')
ylabel('F - per unit')
legend('Open Loop','PID')
grid on
%%
Data1=Tamb;
figure(2)
plot(Data1,'b','linewidth',2)
title('Ambient Temperature')
xlabel('time - s ')
ylabel('Tamb - Celicious')
grid on
%%
Data1=P;
figure(3)
plot(Data1,'b','linewidth',2)
title('Demand Power')
xlabel('time - s ')
ylabel('Pd - per unit')
grid on
%%
Data1=IGV;
Data2=IGV_control;
figure(4)
plot(Data1,'b','linewidth',2)
hold on
plot(Data2,'r','linewidth',1)
title('Inlet Guide Van Position')
xlabel('time - s ')
ylabel('IGV - per unit')
legend('Open Loop','PID')
grid on
%%
Data1=N;
Data2=N_control;
figure(5)
plot(Data1,'b','linewidth',2)
hold on
plot(Data2,'r','linewidth',1)
title('Turbine Speed')
xlabel('time - s ')
ylabel('N - per unit')
legend('Open Loop','PID')
grid on
%%
Data1=P;
Data2=Pd;
figure(6)
plot(Data1,'b','linewidth',2)
hold on
plot(Data2,'r','linewidth',1)
title('Power')
xlabel('time - s ')
ylabel('Amplitude - per unit ')
legend('P','Pd')
grid on
%%
Data1=Tx;
Data2=Tx_control;
figure(7)
plot(Data1,'b','linewidth',2)
hold on
plot(Data2,'r','linewidth',1)
title('Exhaust Gas Temperature')
xlabel('time - s ')
ylabel('Tx - Celicious')
legend('Open Loop','PID')
grid on
%%
Data1=controleffort_F;
Data2=controleffort_IGV;
figure(8)
subplot(2,1,1)
plot(Data1,'b','linewidth',2)
title('Control Effort of Fuel Flow')
xlabel('time - s')
ylabel('Amp - per unit ')
grid on
subplot(2,1,2)
plot(Data2,'k','linewidth',2)
title('Control Effort of IGV')
xlabel('time - s')
ylabel('Amp - per unit ')
grid on
%%
switch answer
    case 'Without Noise'
        disp('Without Noise')      
    case 'With Noise'
Data1=noise_F;
Data2=noise_igv;
figure(9)
subplot(2,1,1)
plot(Data1,'b','linewidth',2)
title('Noise of Fuel Flow')
xlabel('time - s')
ylabel('Amp - per unit ')
grid on
subplot(2,1,2)
plot(Data2,'b','linewidth',2)
title('Noise of IGV')
xlabel('time - s ')
ylabel('Amp - per unit ')
grid on
end
