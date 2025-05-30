clear;
clc;

fis = readfis('controlveiculo');

% Constantes da via
velmaxvia = 100;        % km/h
distsegvia = 20;        % metros
difvelveiculosvia = 30; % km/h

% Estado inicial dos veículos
vel_A = 100;
vel_B = 120;
vel_C = 90;

distAB = 30;
distBC = 25;

% Inicializa distâncias percorridas
distperc_A = 0;
distperc_B = 0;
distperc_C = 0;

% Armazena os dados
dados = zeros(3600, 9); 
% colunas: tempo, distAB, distBC, velA, velB, velC, difAB, difBC, acelC

for i = 1:3600
    % ========================
    % Controle do Veículo B
    % ========================
    velB_norm = vel_B / (velmaxvia * 2);
    distAB_norm = min(max(distAB / (distsegvia * 2), 0), 1);
    difAB = vel_A - vel_B;
    difAB_norm = difAB / difvelveiculosvia;
    acel_B = 2 * evalfis(fis, [velB_norm distAB_norm difAB_norm]);

    vel_B = vel_B + acel_B;
    vel_B = min(max(vel_B, 0), velmaxvia);

    % ========================
    % Controle do Veículo C
    % ========================
    velC_norm = vel_C / (velmaxvia * 2);
    distBC_norm = min(max(distBC / (distsegvia * 2), 0), 1);
    difBC = vel_B - vel_C;
    difBC_norm = difBC / difvelveiculosvia;
    acel_C = 2 * evalfis(fis, [velC_norm distBC_norm difBC_norm]);

    vel_C = vel_C + acel_C;
    vel_C = min(max(vel_C, 0), velmaxvia);

    % ========================
    % Atualiza distâncias percorridas
    % ========================
    distperc_A = distperc_A + vel_A / 3.6;
    distperc_B = distperc_B + vel_B / 3.6;
    distperc_C = distperc_C + vel_C / 3.6;

    distAB = distperc_A - distperc_B;
    distBC = distperc_B - distperc_C;

    % Armazena os dados
    dados(i, :) = [i distAB distBC vel_A vel_B vel_C difAB difBC acel_C];
end

% ====== GRÁFICOS ======

figure;
plot(dados(:,1), dados(:,2), 'r', dados(:,1), dados(:,3), 'b');
legend('Distância A-B', 'Distância B-C');
title('Distância entre os Veículos');
xlabel('Tempo (s)');
ylabel('Distância (m)');

figure;
plot(dados(:,1), dados(:,5), 'g', dados(:,1), dados(:,6), 'm');
legend('Velocidade B', 'Velocidade C');
title('Velocidade dos Veículos Controlados');
xlabel('Tempo (s)');
ylabel('Velocidade (km/h)');

figure;
plot(dados(:,1), dados(:,7), 'k', dados(:,1), dados(:,8), 'b');
legend('Diferença A-B', 'Diferença B-C');
title('Diferença de Velocidade');
xlabel('Tempo (s)');
ylabel('Diferença (km/h)');

figure;
plot(dados(:,1), dados(:,9));
title('Aceleração Aplicada no Veículo C');
xlabel('Tempo (s)');
ylabel('Aceleração (km/h por passo)');
