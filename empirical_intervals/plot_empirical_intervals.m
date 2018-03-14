function [medianhandle, fillhandle, settings] = ...
    plot_empirical_intervals(time, intervals, inputsettings)
% Settings for plotting emprical intervals
% Options:
% - colormap: jet, parula, hsv, etc. (see MathWorks)
% - figID: specify figure handle - leave empty to generate new figure;
% - colorscheme: 'spectrum' or 'gradient';
% - transparency_level: # number between 0 (translucent) and 1 (opaque);
% - initialcolor: [r,g,b] - dimmest (lightest) color - used in
% 'gradient' color scheme
% - meanmodelstyle: plot style/color for mean model response

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