clc;
clear;

% Função objetivo
f = @(x) 0.5*x(1)^2 + 0.5*x(2)^2 - x(1)*x(2) - 2*x(1) - 6*x(2);

% Restrições lineares: A*x <= b
A = [1 1;
    -1 1;
     2 2];
b = [2; 2; 3];

% Limites inferiores
lb = [0 0];
ub = [5 5]; % limite arbitrário superior

% GA
[x_opt, fval] = ga(f, 2, A, b, [], [], lb, ub);

% Malha para plotagem
[x1_grid, x2_grid] = meshgrid(0:0.1:3, 0:0.1:3);
z = 0.5*x1_grid.^2 + 0.5*x2_grid.^2 - x1_grid.*x2_grid - 2*x1_grid - 6*x2_grid;

figure;
mesh(x1_grid, x2_grid, z);
hold on;
plot3(x_opt(1), x_opt(2), fval, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');

xlabel('x1'); ylabel('x2'); zlabel('f(x)');
title('Questão 3 - Ponto ótimo em vermelho');
grid on;
