import love_system.*

% set values to the parameters
a = 1;
b = 2;
J0 = 0.5;
R0 = 0.8;

% time interval and initial conditions
tinterval = [0 10];
initial_conditions = [R0; J0];

% solve the system of differential equations
[t, y] = ode45(@(t, y) love_or_hate(y, a, b), tinterval, initial_conditions);

% solutions
R = y(:, 1);    
J = y(:, 2);

% find the time intervals where both R(t) and J(t) are positive
positive_intervals = [];
for i = 1:length(t)-1
    if R(i) > 0 && J(i) > 0
        if isempty(positive_intervals)
            positive_intervals = [t(i)];
        end
    else
        if ~isempty(positive_intervals)
            positive_intervals = [positive_intervals t(i-1)];
        end
    end
end

% calculate total time of the positive intervals
total_positive_time = sum(diff(positive_intervals));


total_time = t(end) - t(1);
percentage = (total_positive_time / total_time) * 100;
disp(percentage);
