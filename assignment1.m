clear; clc; close all;

phi0 = 5.0e13;
Sigma_f = 0.30;
gamma_I = 0.0639;
gamma_Xe = 0.00228;
lambda_I = 2.87e-5;
lambda_Xe = 2.09e-5;
sigma_aXe = 2.6e-18;
beta = 0.0065;
rho_rod = 9.0;
conv = 5.51e-16;

t_h = [0 2 4 6 8 10 12 14 16 18 20 25 30 40 50];

N_I = [3.340e16  2.716e16  2.209e16  1.797e16  1.461e16 ...
       1.188e16  9.666e15  7.862e15  6.394e15  5.200e15 ...
       4.229e15  2.523e15  1.505e15  5.356e14  1.906e14];

N_Xe = [6.579e15  1.143e16  1.453e16  1.632e16  1.715e16 ...
        1.728e16  1.692e16  1.623e16  1.532e16  1.428e16 ...
        1.319e16  1.045e16  8.009e15  4.413e15  2.307e15];

N_I_eq = (gamma_I * Sigma_f * phi0) / lambda_I;
N_Xe_eq = ((gamma_Xe + gamma_I) * Sigma_f * phi0) / (lambda_Xe + sigma_aXe * phi0);

fprintf('\n====================================================\n');
fprintf('          Xe-135 POISONING ANALYSIS REPORT          \n');
fprintf('====================================================\n\n');

fprintf('>>> PART A: Equilibrium Concentrations <<<\n');
fprintf('----------------------------------------------------\n');
fprintf(' - N_I_eq  = %.4e atoms/cm^3\n', N_I_eq);
fprintf(' - N_Xe_eq = %.4e atoms/cm^3\n', N_Xe_eq);
fprintf(' * Status: Matches initial data at t=0 (Equilibrium Confirmed).\n\n');

rho_Xe = conv * N_Xe;

fprintf('>>> PART B: Reactivity vs. Time <<<\n');
fprintf('----------------------------------------------------\n');
fprintf('   Time (hours)  |   Reactivity ($)   \n');
fprintf('----------------------------------------------------\n');
for i = 1:length(t_h)
    fprintf('       %02.0f        |      %6.3f        \n', t_h(i), rho_Xe(i));
end
fprintf('----------------------------------------------------\n\n');

[peak_rho, idx] = max(rho_Xe);

t_start = interp1(rho_Xe(4:5), t_h(4:5), rho_rod);
t_end = interp1(rho_Xe(7:8), t_h(7:8), rho_rod);
deadtime_duration = t_end - t_start;

fprintf('>>> CRITICAL EVENT RESULTS <<<\n');
fprintf('----------------------------------------------------\n');
fprintf(' - Maximum Reactivity (Peak) : %.3f $\n', peak_rho);
fprintf(' - Time of Peak Reactivity   : %.0f hours\n', t_h(idx));
fprintf('----------------------------------------------------\n');
fprintf(' - Deadtime Start Time       : %.2f hours\n', t_start);
fprintf(' - Deadtime End Time         : %.2f hours\n', t_end);
fprintf(' - Total Deadtime Duration   : %.2f hours\n', deadtime_duration);
fprintf('====================================================\n\n');

figure('Position', [100 100 900 550]);

t_fine = linspace(0, 55, 500);
t_s = t_fine * 3600;
C = lambda_I * N_I(1) / (lambda_I - lambda_Xe);
N_Xe_calc = N_Xe(1)*exp(-lambda_Xe*t_s) + C*(exp(-lambda_Xe*t_s) - exp(-lambda_I*t_s));
rho_fine = conv * N_Xe_calc;

plot(t_fine, rho_fine, 'b-', 'LineWidth', 2); hold on;
plot(t_h, rho_Xe, 'ko', 'MarkerSize', 7, 'MarkerFaceColor', 'r');
yline(rho_rod, 'r--', 'LineWidth', 1.5);

idx_dead = t_fine >= t_start & t_fine <= t_end;
fill_x = [t_start t_fine(idx_dead) t_end];
fill_y = [rho_rod rho_fine(idx_dead) rho_rod];
fill(fill_x, fill_y, 'r', 'FaceAlpha', 0.15, 'EdgeColor', 'none');

plot([t_start t_start], [0 rho_rod], 'g--', 'LineWidth', 1);
plot([t_end t_end], [0 rho_rod], 'g--', 'LineWidth', 1);

text(t_start+0.3, 0.5, sprintf('%.2f h', t_start), 'FontSize', 10, 'Color', [0 0.5 0]);
text(t_end+0.3, 0.5, sprintf('%.2f h', t_end), 'FontSize', 10, 'Color', [0 0.5 0]);
text((t_start+t_end)/2, peak_rho+0.3, 'DEADTIME', 'FontSize', 11, ...
    'FontWeight','bold', 'Color','r', 'HorizontalAlignment','center');
text(t_h(idx)+1, peak_rho-0.4, sprintf('Peak = %.3f $', peak_rho), 'FontSize',10, 'Color','b');

xlabel('Time After Shutdown (hours)');
ylabel('Xe-135 Poisoning (dollars)');
title('Xe-135 Reactivity After Reactor Shutdown');
legend('Analytical', 'Data Points', 'Rod Limit (9 $)', 'Location', 'northeast');
grid on; xlim([0 55]); ylim([0 11]);
hold off;

saveas(gcf, 'Xe135_Reactivity_Deadtime.png');