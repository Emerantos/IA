clc;
clear;

% Função objetivo: minimizar a área A = xy + 2xz + 2yz
area_surface = @(x) x(1)*x(2) + 2*x(1)*x(3) + 2*x(2)*x(3);

% Restrição não linear: xyz = 4 -> xyz - 4 = 0
nonlcon = @(x) deal([], x(1)*x(2)*x(3) - 4);  % ceq = 0

% Limites: x, y, z > 0 → vamos usar mínimo de 0.01 por segurança
lb = [0.01 0.01 0.01];
ub = [10 10 10];

% Executar algoritmo genético
[x_opt, area_min] = ga(area_surface, 3, [], [], [], [], lb, ub, nonlcon);

fprintf('Dimensões ótimas:\n');
fprintf('x = %.4f m\n', x_opt(1));
fprintf('y = %.4f m\n', x_opt(2));
fprintf('z = %.4f m\n', x_opt(3));
fprintf('Área mínima da superfície = %.4f m²\n', area_min);
fprintf('Volume = %.4f m³ (verificação)\n', x_opt(1)*x_opt(2)*x_opt(3));
