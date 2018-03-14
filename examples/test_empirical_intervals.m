% Demonstrate features available in the empirical intervals toolbox.
% For these examples we consider the Helmholtz energy and distributions
% for alpha_1 and alpha_11 for N sets of data.  We also compute the
% covariance matrix.

% setup workspace
clear; close all; clc;

% define path to the matlab toolbox
% assuming this example is run from the downloaded folder, the relative
% path can be add via
addpath('../empirical_intervals/');

% Define polarization grid
Pf = 0.8;
P = 0:.01:Pf;

% Define mean parameter values and variances
alpha_1 = -389.4;
alpha_11 = 761.3;
n = length(P);

sigma = 2.2;
var = sigma^2;

% Compute Helmholtz energy
psi = alpha_1*P.^2 + alpha_11*P.^4;

% Compute the derivatives with respect to alpha_1 and alpha_11 and compute the
% sensitivity matrix X, Fisher information matrix F, and covariance matrix V.
psi_alpha_1 = P.^2;
psi_alpha_11 = P.^4;
X = [psi_alpha_1; psi_alpha_11];
F = X*X';
Finv = inv(F);
V = var*Finv;

% For N = 1000 iterates, compute alpha_1, alpha_11 and psi and plot.
N = 1e+3;
for j = 1:N
    error = sigma*randn(size(P));
    obs = psi + error;
    q(:,j) = Finv*X*obs';
    Y(j,:) = obs;
end

%% Define bounded regions, i.e.,
% limits = [left1, left2, ..., center, ..., right2, right1]

% limits = [0.025,0.5,0.975];
% This corresponds to 95% intervals with median/mean model response
% denoted by 0.5 (center).
%   limits = [0.025,0.5,0.975];

% limits = [0.005,0.025,0.05,0.25,0.5,0.75,0.9,0.975,0.995];
% This corresponds to 99%, 95%, 90%, and 50% intervals with median/mean model response
% denoted by 0.5 (center).
limits = [0.005,0.025,0.05,0.25,0.5,0.75,0.9,0.975,0.995];

% Generate Empirical Intervals
Y_empirical_intervals = generate_empirical_intervals(Y, limits);

%% Example 1
% Test:
% - default settings
[mh, fillh] = plot_empirical_intervals(P, Y_empirical_intervals);
axis([0 Pf -60 80])
set(gca,'Fontsize',[20]);
xlabel('Polarization P')
ylabel('Helmholtz Energy \psi')
legend([mh, fillh(1:4)], {'Mean', '99%', '95%','90%','50%'}, 'Location', 'NorthWest')

%% Example 2
% Test:
% - colorscheme - 'gradient'
clear settings
settings.colorscheme = 'gradient';

[mh, fillh] = plot_empirical_intervals(P, Y_empirical_intervals, settings);
axis([0 Pf -60 80])
set(gca,'Fontsize',[20]);
xlabel('Polarization P')
ylabel('Helmholtz Energy \psi')
legend([mh, fillh(1:4)], {'Mean', '99%', '95%','90%','50%'}, 'Location', 'NorthWest')

%% Example 3
% Test:
% - colorscheme = 'gradient'
% - initial_color = [0.5, 0.9, 0.7];
clear settings
settings.colorscheme = 'gradient';
settings.initial_color = [0.5, 0.9, 0.7];

[mh, fillh] = plot_empirical_intervals(P, Y_empirical_intervals, settings);
axis([0 Pf -60 80])
set(gca,'Fontsize',[20]);
xlabel('Polarization P')
ylabel('Helmholtz Energy \psi')
legend([mh, fillh(1:4)], {'Mean', '99%', '95%','90%','50%'}, 'Location', 'NorthWest')

%% Example 4
% Test:
% - colorscheme = 'spectrum'
clear settings
settings.colorscheme = 'spectrum';

[mh, fillh] = plot_empirical_intervals(P, Y_empirical_intervals, settings);
axis([0 Pf -60 80])
set(gca,'Fontsize',[20]);
xlabel('Polarization P')
ylabel('Helmholtz Energy \psi')
legend([mh, fillh(1:4)], {'Mean', '99%', '95%','90%','50%'}, 'Location', 'NorthWest')

%% Example 5
% Test:
% - figID = gcf
clear settings
settings.figID = figure(10);
settings.transparency_level = 0.5;

% Test adding empirical intervals to existing plot with transparency
figure(10)
pd = plot(P,Y,':k',P,0*P,'k','linewidth',1.0);

[mh, fillh] = plot_empirical_intervals(P, Y_empirical_intervals, settings);
axis([0 Pf -60 80])
set(gca,'Fontsize',[20]);
xlabel('Polarization P')
ylabel('Helmholtz Energy \psi')
legend([pd(1), mh, fillh(1:4)], {'Raw Data', 'Mean', '99%', '95%','90%','50%'}, 'Location', 'NorthWest')

%% Example 6
% Test:
% - colormap = hot
clear settings
settings.colorscheme = 'spectrum';
settings.colormap = hot;

[mh, fillh, settings] = plot_empirical_intervals(P, Y_empirical_intervals, settings);
axis([0 Pf -60 80])
set(gca,'Fontsize',[20]);
xlabel('Polarization P')
ylabel('Helmholtz Energy \psi')
legend([mh, fillh(1:4)], {'Mean', '99%', '95%','90%','50%'}, 'Location', 'NorthWest')