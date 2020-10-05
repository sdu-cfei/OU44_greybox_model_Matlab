%R2C2 model of a building zone
%Konstantin Filonenko, 21.09.20, SDU Center for energy informatics
%Reproduced from the original Modelica model of Krzysztof Arendt (SDU Center for Energy Informatics)
%Usage: OU44model(400, 15, 0, 21+273.15, 0, -1000)
function R2C2_CO2
filename='Test1_for_Tsinghua_';
modelica_solvers = {'Dassl', 'Lsodar', 'Rkfix2',  'Rkfix3',  'Rkfix3', 'Radau', 'Esdirk23a', 'Esdirk34a', 'Esdirk45a', 'Euler', 'Cvode', 'Dopri853', 'Dopri45'};
lables = {'Tair', 'Twall', 'CO2'};
matlab_solvers = {'45', '23', '15s', '23s', '23t', '23tb'};
for i = 1:3
    figure(i)
    hold on
    for ms=matlab_solvers
        out = OU44model(str2func(['ode', ms{1}]), 400, 15+273.15, 1, 21+273.15, 1, -1);
        plot(out.x, out.y(i,:),'o')
    end
    for ms=modelica_solvers
        load([filename, ms{1}, '.mat'])
        plot(data(:,1), data(:, i+1))
    end
    ylabel(lables{i})
    ma=strcat('Matlab@ode', matlab_solvers);
    mo=strcat('Modelica@', modelica_solvers);
    legend({ma{:}, mo{:}}, 'Location', 'southwest')
    hold off
end

end

function outputs = OU44model(matlab_solvers, solrad, Tout, occ, Tvestp, verate, qrad)
[Tair0, Twall0] = deal(20 + 273.15); %Initial temperature of indoor air and inner wall [degC]
CO20=400; %Initial CO2 concentration [ppmv]
inputs = [solrad; Tout; occ; Tvestp; verate; qrad];
states0 = [Tair0; Twall0; CO20];
tstart = 0; tstop = 86400;
outputs = matlab_solvers(@(time, states) R2C2(time, states, inputs), [tstart, tstop], states0);
end

function dxdt=R2C2(t, T, u)
load('parameters')
Re = Rext/(3*Vi^(2/3)); Ri = Rint/(3*Vi^(2/3));
C = tmass*Vi*1.2*1005; Ci = imass*Vi*1.2*1005;
assert(T(1)<u(4),'wrong assumptions')
dxdt(1,1) = (T(1)*(0.335*u(5)*maxVent - 2.650*occeff*u(3) - 1/Re - 1/Ri) + T(2)/Ri + u(2)/Re - 0.335*max(T(1),u(4))*maxVent*u(5) + maxHeat*u(6) + shgc*u(1) + 853.52*occeff*u(3))/C;
dxdt(2,1) = (T(1)-T(2))/(Ri*Ci);
dxdt(3,1) = 1e6*CO2pp*(Vinf+maxVent*u(5))*u(3)*(CO2n-T(3))/(3600*Vi);
end

%Licensed by the International Building Performance Simulation Association (IBPSA) under the Modelica License 2
%Copyright (c) 2016, International Building Performance Simulation Association (IBPSA).
%This Matlab file is free software and the use is completely at your own risk; it can be redistributed and/or modified under the terms of the Modelica license 2, see the license conditions (including the disclaimer of warranty) here or at http://www.modelica.org/modelica-legal-documents/ModelicaLicense2.html.
%Copyright - BSD License applies
%Copyright (c) 2016, International Building Performance Simulation Association (IBPSA). All rights reserved.
%If you have questions about your rights to use or distribute this software, please contact MWetter@lbl.gov.
