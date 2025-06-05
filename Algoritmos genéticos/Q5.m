clc;
clear;

% Função objetivo (minimização)
f = @(x) 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;

% Restrições não lineares
nonlcon = @(x) deal(...
    [x(1)*x(2) + x(1) - x(2) + 1.5;  % <= 0
     10 - x(1)*x(2)], ...           % <= 0
    []);                           % nenhuma igualdade

% Limites
lb = [0 0];
ub = [1 13];

% GA
[x_opt, fval] = ga(f, 2, [], [], [], [], lb, ub, nonlcon);

% Malha para visualização
[x1_grid, x2_grid] = meshgrid(0:0.05:1, 0:0.5:13);
z = 100*(x2_grid - x1_grid.^2).^2 + (1 - x1_grid).^2;

figure;
mesh(x1_grid, x2_grid, z);
hold on;
plot3(x_opt(1), x_opt(2), fval, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');

xlabel('x1'); ylabel('x2'); zlabel('f(x)');
title('Questão 5 - Ponto ótimo em vermelho');
grid on;
clc;
clear;

% Função objetivo (minimização)
f = @(x) 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;

% Restrições não lineares
nonlcon = @(x) deal(...
    [x(1)*x(2) + x(1) - x(2) + 1.5;  % <= 0
     10 - x(1)*x(2)], ...           % <= 0
    []);                           % nenhuma igualdade

% Limites
lb = [0 0];
ub = [1 13];

% GA
[x_opt, fval] = ga(f, 2, [], [], [], [], lb, ub, nonlcon);

% Malha para visualização
[x1_grid, x2_grid] = meshgrid(0:0.05:1, 0:0.5:13);
z = 100*(x2_grid - x1_grid.^2).^2 + (1 - x1_grid).^2;

figure;
mesh(x1_grid, x2_grid, z);
hold on;
plot3(x_opt(1), x_opt(2), fval, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');

xlabel('x1'); ylabel('x2'); zlabel('f(x)');
title('Questão 5 - Ponto ótimo em vermelho');
grid on;
