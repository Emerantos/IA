clc;
clear;

% Função objetivo (Rosenbrock)
objetivo = @(x) 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;

% Restrição não linear
nonlcon = @(x) deal( ...
    (x(1) - 1/3)^2 + (x(2) - 1/3)^2 - (1/3)^2, ... % c(x) <= 0
    [] ... % ceq(x) == 0 (não há igualdade)
);

% Limites das variáveis
lb = [0, 0.2];
ub = [0.5, 0.8];

% Rodar GA para encontrar o mínimo
opts = optimoptions('ga', 'Display', 'iter');
[x_min, fval_min] = ga(objetivo, 2, [], [], [], [], lb, ub, nonlcon, opts);

fprintf('Mínimo encontrado em x1 = %.4f, x2 = %.4f, f(x) = %.4f\n', x_min(1), x_min(2), fval_min);

% Rodar GA para encontrar o máximo (invertendo a função)
[x_max, fval_max_neg] = ga(@(x)-objetivo(x), 2, [], [], [], [], lb, ub, nonlcon, opts);
fval_max = -fval_max_neg;

fprintf('Máximo encontrado em x1 = %.4f, x2 = %.4f, f(x) = %.4f\n', x_max(1), x_max(2), fval_max);

% Plotar a função com mesh
[x1, x2] = meshgrid(0:0.005:0.5, 0.2:0.005:0.8);
f = 100.*(x2 - x1.^2).^2 + (1 - x1).^2;

figure;
mesh(x1, x2, f);
xlabel('x1');
ylabel('x2');
zlabel('f(x)');
title('f(x) = 100(x2 - x1^2)^2 + (1 - x1)^2');
hold on;

% Adicionar os pontos mínimo e máximo
plot3(x_min(1), x_min(2), fval_min, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
plot3(x_max(1), x_max(2), fval_max, 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g');
legend('Superfície f(x)', 'Mínimo', 'Máximo');
hold off;
