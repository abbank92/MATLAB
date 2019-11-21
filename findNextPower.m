function [p, c] = findNextPower(eps, radEps, k, knownTerms)
% Alex Bank (c) 2019
% Calculate the next power in the psuedospectral radius
%   eps is a row vector of small epsilon values
%   radEps is the corresponding psuedospectral radius of each epsilon term
%   k is the dimension of the Jordan block
%   knowTerms is an (n)x2 matrix with constants in the first column
%             and powers in the second column
% Function returns the next power as p and a guess at the constant as c
% Uses a linear polynomial to find the next power

x = log(eps);

d = size(knownTerms);
knownSum = zeros(1, length(eps));
for i = 1:d(1)
    tempEps = arrayfun(@(x) x^(knownTerms(i,2)), eps);
    knownSum = knownSum + knownTerms(i,1)*tempEps;
end

radPower = arrayfun(@(x) x^k, radEps);

y = log(radPower - knownSum);

fit = polyfit(x,y,1);
p = fit(1);
c = exp(fit(2));

end