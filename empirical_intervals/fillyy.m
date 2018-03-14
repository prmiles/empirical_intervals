function h = fillyy(x,y1,y2,col,trans)
%FILLYY  Fills space between lines
% fillyy(x,y1,y2,col) fill space between lines (x,y1) and (x,y2)
%  with color col

% Marko Laine <Marko.Laine@Helsinki.FI>
% $Revision: 1.2 $  $Date: 2003/05/08 18:55:23 $
% Adapted by Paul Miles - 2018/03/01

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
