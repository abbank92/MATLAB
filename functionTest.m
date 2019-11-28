%% Function Test
J = [0 1 0; 0 0 1; 0 0 0];

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
% c2 --> ??

%% Solving for ck4c
ck4bSolved = zeros(1,10);
for index = 0:9
    smolEps = eps(length(eps)-index);
    smolRad = radEps(length(radEps)-index);
    ck4bSolved(index+1) = (smolRad^4 - smolEps - smolEps^(6/4))/(smolEps^(8/4));
end


ck4cSolved = zeros(1,10);
for index = 0:9
    smolEps = eps(length(eps)-index);
    smolRad = radEps(length(radEps)-index);
    ck4cSolved(index+1) = (smolRad^4 - smolEps - smolEps^(6/4) - 6/4*smolEps^(8/4))/(smolEps^(10/4));
end

%% Moving on... k=5
J5 = [0 1 0 0 0; 0 0 1 0 0; 0 0 0 1 0; 0 0 0 0 1; 0 0 0 0 0];

eps = (1e7):(1e3):(1e8);
eps = arrayfun(@(x) 1/x, eps);
radEps = zeros(1, length(eps));
for k = 1:length(eps)
    radEps(k) = findradius(J5,eps(k));
end

knownTerms = [1 1];
k = 5;
[pk5, ck5] = findNextPower(eps, radEps, k, knownTerms);


% hmmmm... so we get 
% p1 --> 1.4
% c1 --> 1

knownTerms = [1 1; 1 1.4];
k = 5;
[pk5b, ck5b] = findNextPower(eps, radEps, k, knownTerms);
% p2 --> 1.8
% c2 --> 1.4

knownTerms = [1 1; 1 1.4; 1.4 1.8];
k = 5;
[pk5c, ck5c] = findNextPower(eps, radEps, k, knownTerms);
% p3 --> 2.2
% c3 --> ??


%% Moving backwards... k=2
J2 = [0 1; 0 0];

eps = (1e7):(1e3):(1e8);
eps = arrayfun(@(x) 1/x, eps);
radEps = zeros(1, length(eps));
for k = 1:length(eps)
    radEps(k) = findradius(J2,eps(k));
end

knownTerms = [1 1];
k = 2;
[pk2, ck2] = findNextPower(eps, radEps, k, knownTerms);

knownTerms = [1 1; 1 2];
k = 2;
[pk2b, ck2b] = findNextPower(eps, radEps, k, knownTerms);
