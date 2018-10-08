function y=generate_empirical_intervals(f,limits)
% Generate Empirical Intervals
%
% Generates empirical intervals based on a set of model responses (f). 
% The intervals limits require a specific form:
%
% ::
%
%   limits = [left1, left2, ..., center, ..., right2, right1]
%
% There should be an odd number of elements in 'limits'.  
% If the center is 0.5, this will correspond to the middle row (or interpolated middle row) of the sorted model responses.  
% Note, the model responses will be sorted in a column wise fashion.
%
% Example: This corresponds to 99%, 95%, 90%, and 50% intervals with median/mean model response
% denoted by 0.5 (center).
%
% ::
%
%   limits = [0.005,0.025,0.05,0.25,0.5,0.75,0.9,0.975,0.995];
%   Y_empirical_intervals = generate_empirical_intervals(Y, limits);
%
% Input:
%   * **f** (array): Model response for various parameter sets.
%   * **limits** (array): Bounds for empirical intervals.
%
% Returns:
%   * **y** (array): Empirical intervals based on limits, with median model response

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
