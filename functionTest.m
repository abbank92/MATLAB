%% Function Test

% Set up a bunch of epsilon values
eps = (1e7):(1e3):(1e8);
eps = arrayfun(@(x) 1/x, eps);

% Get corresponding radii
radEps = zeros(1, length(eps));
for k = 1:length(eps)
    radEps(k) = findradius(J,eps(k));
end

%% Testing
% We test the fuction for the second term in J_3
k = 3;
knownTerms = [1 1];
[p1, c1] = findNextPower(eps, radEps, k, knownTerms);
% Returns p1 = 1.66667, which checks out... a good sign!

% Onto the next power
knownTerms = [1 1; 1 5/3];
[p2, c2] = findNextPower(eps, radEps, k, knownTerms);
% Returns p2 = 2.33333, check!

% Onto the next power
knownTerms = [1 1; 1 5/3; 5/3 7/3];
[p3, c3] = findNextPower(eps, radEps, k, knownTerms);
% okay, so it breaks here...
% probably means the numbers are getting too small
% we'll try setting up new eps values and rerunning

%% Testing 2

eps = (1e3):(1e5);
eps = arrayfun(@(x) 1/x, eps);
radEps = zeros(1, length(eps));
for k = 1:length(eps)
    radEps(k) = findradius(J,eps(k));
end

knownTerms = [1 1; 1 5/3; 5/3 7/3];
[p3, c3] = findNextPower(eps, radEps, k, knownTerms);




%% Moving on... k=4
J = [0 1 0 0; 0 0 1 0; 0 0 0 1; 0 0 0 0];

eps = (1e7):(1e3):(1e8);
eps = arrayfun(@(x) 1/x, eps);
radEps = zeros(1, length(eps));
for k = 1:length(eps)
    radEps(k) = findradius(J,eps(k));
end

knownTerms = [1 1];
k = 4;
[pk4, ck4] = findNextPower(eps, radEps, k, knownTerms);
% p1 --> 1.5
% c1 --> 1 (maybe)

knownTerms = [1 1; 1 1.5];
[pk4b, ck4b] = findNextPower(eps, radEps, k, knownTerms);
% p2 --> 2
% c2 --> 1.5 (maybe)

knownTerms = [1 1; 1 1.5; 1.5 2];
[pk4c, ck4c] = findNextPower(eps, radEps, k, knownTerms);
% p2 --> 2
