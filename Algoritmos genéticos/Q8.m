clc;
clear;

% Função objetivo
f = @(x) x.^2 - 3*x + 4;

% GA para encontrar mínimo
[x_min, fval_min] = ga(f, 1, [], [], [], [], -10, 10);
fprintf('Mínimo de f(x) = x^2 - 3x + 4 ocorre em x = %.4f, f = %.4f\n', x_min, fval_min);

% Plot
x = -10:0.01:10;
y = f(x);
figure;
plot(x, y, 'b', 'LineWidth', 2);
hold on;
plot(x_min, fval_min, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
xlabel('x'); ylabel('f(x)');
title('f(x) = x^2 - 3x + 4');
legend('f(x)', 'Mínimo');
grid on;
