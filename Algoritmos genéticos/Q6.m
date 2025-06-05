clc;
clear;

% Função objetivo
objetivo = @(x) (x(1)^2 + x(2)^2 - 1)^2;

% Restrição não linear
nonlcon = @(x) deal([
    1 - (x(1) + x(2));          % x1 + x2 >= 1 → 1 - (x1 + x2) <= 0
    0.5 - x(1)*x(2);            % x1*x2 >= 0.5
    x(1)^2 - x(2);              % x2 >= x1^2
    x(2)^2 - x(1)               % x1 >= x2^2
], []);

% Limites
lb = [-1, -1];
ub = [1, 1];

% Mínimo
[x_min, fval_min] = ga(objetivo, 2, [], [], [], [], lb, ub, nonlcon);
fprintf('Mínimo em x1 = %.4f, x2 = %.4f, f = %.4f\n', x_min(1), x_min(2), fval_min);

% Máximo (invertendo a função)
[x_max, fval_max_neg] = ga(@(x) -objetivo(x), 2, [], [], [], [], lb, ub, nonlcon);
fval_max = -fval_max_neg;
fprintf('Máximo em x1 = %.4f, x2 = %.4f, f = %.4f\n', x_max(1), x_max(2), fval_max);

% Mesh
[x1, x2] = meshgrid(-1:0.01:1, -1:0.01:1);
f = (x1.^2 + x2.^2 - 1).^2;
figure;
mesh(x1, x2, f);
xlabel('x1'); ylabel('x2'); zlabel('f(x)');
title('f(x) = (x1^2 + x2^2 - 1)^2');
hold on;
plot3(x_min(1), x_min(2), fval_min, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
plot3(x_max(1), x_max(2), fval_max, 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g');
legend('f(x)', 'Mínimo', 'Máximo');
hold off;
