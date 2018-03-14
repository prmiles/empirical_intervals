function y=generate_empirical_intervals(x,limits)
%PLIMS Empirical quantiles
% plims(x,p)  calculates p quantiles from columns of x

% Marko Laine <Marko.Laine@Helsinki.FI>
% $Revision: 1.4 $  $Date: 2007/05/21 11:19:12 $
% Adapted by Paul Miles - 2018/03/01

% Check input argument
if nargin<2 || isempty(limits)   
   limits = [0.25,0.5,0.75];
end

if mod(length(limits),2) == 0 % is odd
    fprintf('Invalid limits specified - Use the format:\n');
    fprintf('limits = [left1, left2, ..., center, ..., right2, right1]\n')
end

[n,m] = size(x); if n==1; n=m;end
y = interp1(sort(x),(n-1)*limits+1);
