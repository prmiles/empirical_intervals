function y=generate_empirical_intervals(f,limits)
% Generates empirical intervals based on a set of model responses (f).  The
% intervals limits require a specific form:
%   limits = [left1, left2, ..., center, ..., right2, right1]
% There should be an odd number of elements in 'limits'.  If the center is
% 0.5, this will correspond to the middle row (or interpolated middle row)
% of the sorted model responses.  Note, the model responses will be sorted
% in a column wise fashion.
%
% Requires:
%   - plims(f,p)  calculates p quantiles from columns of f

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

[n,m] = size(f); if n==1; n=m;end
y = interp1(sort(f),(n-1)*limits+1);
