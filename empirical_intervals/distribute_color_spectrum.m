function [psty] = distribute_color_spectrum(nds, cmap)
% evenly distribution color palette across nds data sets

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