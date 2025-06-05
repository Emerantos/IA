% Define a função a ser **minimizada** (negativa da função g)
g = @(x) -1 * (2 - 2*((x - 0.1)/0.9)^2) * (sin(5*pi*x))^6;

% Intervalo da variável: 0 <= x <= 1
lb = 0;  % limite inferior
ub = 1;  % limite superior

% Rodar o algoritmo genético
[x_opt, fval] = ga(g, 1, [], [], [], [], lb, ub);

% Resultado
fprintf('x ótimo: %.4f\n', x_opt);
fprintf('g(x) máximo: %.4f\n', -fval);

% Plotando a função
x_vals = linspace(0, 1, 1000);
y_vals = (2 - 2*((x_vals - 0.1)/0.9).^2) .* (sin(5*pi*x_vals)).^6;

figure;
plot(x_vals, y_vals, 'b', 'LineWidth', 2);
hold on;
plot(x_opt, -fval, 'ro', 'MarkerSize', 10, 'LineWidth', 2);
title('Função g(x) e ponto de máximo');
xlabel('x');
ylabel('g(x)');
grid on;
legend('g(x)', 'Máximo encontrado');
