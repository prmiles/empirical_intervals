function h = fillyy(x,y1,y2,col,trans)
% Fill interval between two lines, (x, y1) and (x, y2)
%
% Fills space between lines. Calling fillyy(x,y1,y2,col) will fill space 
% between lines (x,y1) and (x,y2) with color col
%
% Input:
%   * **x** (array): independent variable
%   * **y1** (array): y value of first line
%   * **y2** (array): y value of second line
%   * **col** (array): color to use in fill command
%   * **trans** (scalar): Transparency level [0,1].
%
% Returns:
%   * **h** (handle): Figure handle
if nargin < 4
   col='red';
end

if nargin < 5 || isempty(trans)
    trans = 1;
end

x  = x(:)';
y1 = y1(:)';
y2 = y2(:)';
n   = length(x);
X = [ x(1),  x,  x(n),  fliplr(x)  ];
Y = [ y1(1), y2, y1(n), fliplr(y1) ];
h = fill(X,Y,col,'Linestyle',':','facealpha',trans);
