%% Test kit for looking at eps-pseudospectra

% Our Matrix
J = [0 1 0; 0 0 1; 0 0 0];

% Set up a bunch of epsilon values
n = 10e5;
eps = zeros(1, n);
for k = 1:n
    % 1/10^2 --> 1/10^7
    eps(k) = 1/(100*k);
end

% Get corresponding radii
rad = zeros(1, n);
for k = 1:n
    rad(k) = findradius(J,eps(k));
end

% A check to make sure the function performs correctly
% As eps --> 0, rad --> eps^(1/3)
rad_cubed = arrayfun(@(x) x^(3), rad);
% This array should approach 1
results = rad_cubed.*(1:n);


%% Proposition: r = (e + a e^2 + b e^3)^(1/3)
% If so can solve a system of linear equations
n=10;
solutions = cell(n, 1);
for k = 1:n  
    e1 = randi(length(eps));
    e2 = randi(length(eps));
    A = [1 eps(e1); 1 eps(e2)];
    B = [(rad(e1)^3-eps(e1))/eps(e1)^2 (rad(e2)^3-eps(e2))/eps(e2)^2];
    B = B';
    X = linsolve(A,B);
    solutions{k} = X;
end
% No consistent solution, so proposition is false


%% Proposition: r = (e + e^p)^(1/3)
% Plot log(e) vs log(r^3 - e) and see if we can get p=slope
logeps = log(eps);
logradminuseps = log(rad_cubed - eps);
plot(logeps, logradminuseps)
% oooo that looks quite straight
p = polyfit(logeps, logradminuseps, 1);
hold on
syms x
fplot(p(1)*x + p(2))
hold off
% Close, but not quite... Let's check w the calculated raidus data
% Should have r = (e + exp(p(2)) e^p(1) )^(1/3)
usingP = arrayfun(@(a) (a + exp(p(2))*a^p(1))^(1/3), eps);
rad - usingP;
% Interestingly close... Let's try finding the slope without polyfit
slopes = zeros(1, length(logeps)-1);
for k = 1:(length(logeps)-1)
    slopes(k) = (logradminuseps(k+1) - logradminuseps(k)) / (logeps(k+1) - logeps(k));
end
% Slopes inconsistent...
% Possible that there are more H.O.T.
% I edited the earlier code to so now we have more eps terms
% and smaller eps terms. It appears p --> 5/3, c --> 0  ???
% We check...
latestP = arrayfun(@(a) (a + a^(5/3))^(1/3), eps);
check = rad - latestP;


%% Proposition: r = (e + e^(5/3) + e^p)^(1/3)
logeps = log(eps);
epsTo5on3 = arrayfun(@(a) a^(5/3), eps);
solvedTerms = log(rad_cubed - eps - epsTo5on3);
plot(logeps, solvedTerms)
p2 = polyfit(logeps, solvedTerms, 1);
hold on
fplot(p2(1)*x + p2(2))
hold off
% p2 --> 2.333, c2 --> ?? (polyfit is saying around 0.51)
anotherGuess = arrayfun(@(a) (a + a^(5/3) + a^(7/3))^(1/3), eps);
check2 = rad - anotherGuess;
% larger epsilon values do not check out for c = 1

% We use eps = 0.01 and solve for c... see if it matches
% what we found using the line fit
eps1 = eps(1);
rad1 = rad(1);
c = (rad1^3 - eps1 - eps1^(5/3))/(eps1^(7/3));
exp(p2(2));

% Okay, this is pretty cool... our constant is 5/3
anotherGuess2 = arrayfun(@(a) (a + a^(5/3) + (5/3)*a^(7/3))^(1/3), eps);
check3 = rad - anotherGuess2;
% larger epsilon values still do not check out...
% guess there's yet another term...

%% More terms
epsTo7on3 =  arrayfun(@(a) a^(7/3), eps);
solvedTerms = log(rad_cubed - eps - epsTo5on3 - (5/3)*epsTo7on3);
p3 = polyfit(logeps, solvedTerms, 1);
% uh oh... now we are getting negative logs in some cases
% p3 is imaginary so looks like we're going to have to back up
% let's try removing the 5/3 constant
solvedTermsNoC = log(rad_cubed - eps - epsTo5on3 - epsTo7on3);
p4 = polyfit(logeps, solvedTermsNoC, 1);
% ok, so we're getting another 7/3 term
% looks like we're bottoming out, so...


%% Proposition: r = (e + a e^(5/3) + b e^(7/3))^(1/3)
rng(0);
n=10;
solutions = cell(n, 1);
for k = 1:n  
    e1 = randi(length(eps))
    e2 = randi(length(eps))
    A = [1 eps(e1)^(2/3); 1 eps(e2)^(2/3)];
    B = [(rad(e1)^3-eps(e1))/eps(e1)^(5/3) (rad(e2)^3-eps(e2))/eps(e2)^(5/3)];
    B = B';
    X = linsolve(A,B)
    solutions{k} = X;
end
% a --> 1, b --> 5/3

%% Other code that didn't quite make the cut
%% Set up eps with larger values
% Set up a bunch of epsilon values
n = 10e5;
eps = zeros(1, n);
for k = 1:n
    % 1 --> 1/10^5
    eps(k) = 1/(k);
end

% Get corresponding radii
rad = zeros(1, n);
for k = 1:n
    rad(k) = findradius(J,eps(k));
end

%% Let's try for another term with larger eps values
% r = (e + e^(5/3) + (5/3)e^(7/3) + c e^p)^(1/3)
logeps = log(eps);
rad_cubed = arrayfun(@(x) x^(3), rad);
epsTo5on3 = arrayfun(@(a) a^(5/3), eps);
epsTo7on3 = arrayfun(@(a) a^(7/3), eps);
solvedTerms = log(rad_cubed - eps - epsTo5on3 - (5/3)*epsTo7on3);
newp = polyfit(logeps, solvedTerms, 1);
% p --> 3, c --> 0.3348... ??
% p = 9/3 makes sense, but not sure about this constant...


