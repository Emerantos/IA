clc;
clear;

% Definir a função objetivo como função anônima
objetivo = @(x) (x(1)^2 + x(2)^2 - 1)^2;

% Definir limites
lb = [-1, -1];  % Limites inferiores
ub = [1, 1];    % Limites superiores

% Usar algoritmo genético para encontrar o mínimo
[x_min, fval_min] = ga(objetivo, 2, [], [], [], [], lb, ub);

fprintf('Mínimo encontrado em x1 = %.4f, x2 = %.4f, f(x) = %.4f\n', x_min(1), x_min(2), fval_min);

% Usar algoritmo genético para encontrar o máximo (invertendo a função)
[x_max, fval_max_neg] = ga(@(x) -objetivo(x), 2, [], [], [], [], lb, ub);
fval_max = -fval_max_neg;

fprintf('Máximo encontrado em x1 = %.4f, x2 = %.4f, f(x) = %.4f\n', x_max(1), x_max(2), fval_max);

% Plotar a função com mesh
[x1, x2] = meshgrid(-1:0.01:1, -1:0.01:1);
f = (x1.^2 + x2.^2 - 1).^2;

figure;
mesh(x1, x2, f);
xlabel('x1');
ylabel('x2');
zlabel('f(x)');
title('Função f(x1, x2) = (x1^2 + x2^2 - 1)^2');
