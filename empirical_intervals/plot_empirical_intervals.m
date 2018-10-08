function [medianhandle, fillhandle, settings] = ...
    plot_empirical_intervals(time, intervals, inputsettings)
% Plot Empirical Intervals
%
% Settings for plotting empirical intervals
%
% `inputsettings`
%   - `colorscheme`: `gradient` or `spectrum`;
%   - `gradient`:
%       * `initialcolor`: [r,g,b] - dimmest (lightest) color
%   - `spectrum`:
%       * `colormap`: jet, parula, hsv, etc. (see MathWorks)
%   - `figID`: specify figure handle - leave empty to generate new figure;
%   - `transparency_level`: # number between 0 (translucent) and 1 (opaque);
%   - `meanmodelstyle`: plot style/color for mean model response
%
% Example:
%
% ::
%
%   settings.colorscheme = 'gradient';
%   settings.initial_color = [0.5, 0.9, 0.7];
%   [mh, fillh] = plot_empirical_intervals(P, Y_empirical_intervals, settings);
% 
% Input:
%   * **time** (array): x-axis variable
%   * **intervals** (array): results generated from :func:`~generate_empirical_intervals`
%   * **inputsettings** (struct) : plot settings
%
% Returns:
%   * **medianhandle** (handle): handle of median plot line
%   * **fillhandle** (handle): handle for fill plots
%   * **settings** (struct): actual settings used to generate plot

% unpack input arguments
if nargin < 3 || isempty(inputsettings)
    inputsettings.defined = 0;
end

inputfields = fields(inputsettings);

% default settings
settings.colormap = parula;
settings.figID = [];
settings.colorscheme = 'gradient';
settings.transparency_level = 1;
settings.initial_color = [0.9, 0.9, 0.9]; % dimmest (lightest) color
settings.meanmodelstyle = '-k'; % plot style/color for mean model response

validfields = fields(settings);

% determine valid fields specified by user
checkfields = intersect(inputfields, validfields);
nvf = length(checkfields);

for ii = 1:nvf
    if isempty(inputsettings.(checkfields{ii}))
    else
        settings.(checkfields{ii}) = inputsettings.(checkfields{ii});
    end
end

% Determine size of intervals array
np = size(intervals,1); % # of rows
nn = (np+1)/2; % median
fillhandle = zeros(1, nn-1);

settings.fillcolors = zeros(nn-1,3);
if strcmp(settings.colorscheme, 'spectrum')
    % Create nn - 1 colors across colormap spectrum
    settings.fillcolors = distribute_color_spectrum(nn - 1, settings.colormap);
elseif strcmp(settings.colorscheme, 'gradient')
    for k = 1:nn-1
        settings.fillcolors(k,:) = settings.initial_color.*0.9.^(k-1);
    end
else
    warning('Invalid color scheme - Use either ''spectrum'' or ''gradient''');
end

% Check figure ID
if isempty(settings.figID)
    figure; % create new figure window
else
    figure(settings.figID)
end

% Add first interval based on initial color
hold on
fillhandle(1) = fillyy(time,intervals(1,:),intervals(2*nn-1,:), settings.fillcolors(1,:), settings.transparency_level);
% Add subseqent intervals at a gradient level
for k=2:(nn-1)
    fillhandle(k) = fillyy(time,intervals(k,:),intervals(2*nn-k,:), settings.fillcolors(k,:), settings.transparency_level);
end
% Add median model response
medianhandle = plot(time, intervals(nn,:),settings.meanmodelstyle,'LineWidth',2);
hold off