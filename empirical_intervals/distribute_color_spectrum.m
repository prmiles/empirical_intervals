function [psty] = distribute_color_spectrum(nds, cmap)
% Distribute color spectrum
%
% Evenly distribution color palette across nds data sets.
%
% Input:
%   * **nds** (integer): Number of data sets
%   * **cmap** (array): Color map (https://www.mathworks.com/help/matlab/ref/colormap.html)
%
% Returns:
%   * **psty** (array): [nds x 3] - RGB distributed across color map

if nargin < 2 || isempty(cmap)
    cmap = jet; % default color map
end

cmp = colormap(cmap);
[mc,~] = size(cmp);

nc = linspace(1,mc,nds)';

psty = zeros(nds,3);
for ii = 1:nds
    psty(ii,:) = interp1((1:1:mc)', cmp, nc(ii));
end