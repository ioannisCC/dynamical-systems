clc
clear
% set up appropriate function handles for each of the functions f(x) and
% V(x).
f = @(x,lambda) (lambda + x - x.^3);
V = @(x,lambda) (-lambda .* x + 0.5 .* x.^2 - 0.25 * x.^4);

% provide an animation for the phase-space plot of the dynamical system
% given by Eq. 1 for the various values of the parameter lambda.

% set the minimum and maximum values of the parameteter lambda.
lambda_min = -2;
lambda_max = 2;
% set the step size for the parameter lambda.
delta_lambda = 0.025;
% set the lambda axis.
lambda = lambda_min:delta_lambda:lambda_max;

% set the minimum and maximum values for the x-axis.
x_min = -3;
x_max = 3;
% set the step size for the x-axis.
dx = 0.01;
% set the x-axis.
x = x_min:dx:x_max;

% create a grid on the cartesian product between the x and lambda axes.
[X,L] = meshgrid(x,lambda);
% evaluate functions f(x,lambda) and V(x,lambda) for each point on the
% grid.
Fo = f(X,L);
Vo = V(X,L);

% create three-dimensional plots of the quantities Fo and Vo.
figure('Name','dynamical dystem function');
surf(X,L,Fo);
xlabel('x');
ylabel('lambda');
zlabel('F(x,lambda)');
grid on

figure('name','potential function');
surf(X,L,Vo);
xlabel('x');
ylabel('lambda');
zlabel('V(x,lambda)');
grid on

% set the minimum and maximum values for the y-axis.
y_min = min(min(min(Fo)),min(min(Vo)));
y_max = max(max(max(Fo)),max(max(Vo)));
% set the step size of the y-axis.
dy = 0.01;
% set the y-axis.
y = y_min:dy:y_max;

% initialize frame counter;
frame_counter = 1;

% create new figure.
figure('Name','dynamical system evolution');
% set the limits of the plotting plane.
axis([x_min x_max y_min y_max]);

for lambda_current = lambda
    % for the current value of the lambda parameter obtain the range of
    % values for the function f(x) and the potential function V(x).
    Fx = f(x,lambda_current);
    Vx = V(x,lambda_current);
    % clear the current plotting window in order to create the current
    % frame of the movie.
    clf
    hold on
    % plot the values of f(x) for each point in the x-axis.
    plot(x,Fx,'-r','LineWidth',1.8);
    % plot the values of the potential function V(x) for each point in the
    % x-axis.
    plot(x,Vx,'--b','LineWidth',1.8);
    % plot the x-axis.
    plot(x,zeros(1,length(x)),'-k','LineWidth',1.8);
    % plot the y-axis.
    plot(zeros(1,length(y)),y,'-k','LineWidth',1.8);
    if(lambda_current < 0)
        plot(lambda_current,0,'o','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',10.0);
    elseif(lambda_current == 0)
       plot(-1,0,'o','MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10.0);
       plot(0,0,'o','MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10.0);
       plot(1,0,'o','MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10.0);
    elseif(lambda_current > 0)
       plot(lambda_current,0,'o','MarkerEdgeColor','k','MarkerFaceColor','b','MarkerSize',10.0);
    end
    xlabel('x');
    ylabel('Fx and Vx');
    grid on
    tlt = title(strcat(['phase-space plot for lambda = ',num2str(lambda_current)]));
    tlt.FontWeight = 'bold';
    lgd = legend({'f(x)','V(x)'});
    lgd.Location = 'northoutside';
    lgd.FontWeight = 'bold';
    hold off
    M(frame_counter) = getframe;
    frame_counter = frame_counter + 1;
end

% play movie.
figure();
movie(M);

% construct the corresponding bifurcation diagram.
% the construction of the bifurcation diagram depends upon a mapping that
% provides the fixed point of the dynamical system given the value of the 
% parameter lambda: 
%                           { -1 (stable fixed point)
%          xo = g(lambda) = | 0  (unstable fixed point)          
%                           { +1 (stable fixed point)
% for lambda <=>0.

% reset the lambda range and the associated axis.
delta_lambda = 0.1;
lambda_negative = lambda_min:delta_lambda:0-0.1;
lambda_positive = 0+0.1:delta_lambda:lambda_max;
lambda_axis = lambda_min:delta_lambda:lambda_max;
% set the xo-axis.
xo_axis = lambda_min:delta_lambda:lambda_max;

% store the stable points for each point in the lambda-axis.
stable_points_n = -1;
stable_points_p = 1;
unstable_points = 0;
lambda_0 = 0;
figure('Name','bifurcation diagram');
axis([lambda_min -lambda_min -2 +2]);
hold on
plot(lambda_negative,stable_points_n,'-ko','LineWidth',1.8,'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',10.0);
plot(lambda_positive,stable_points_p,'-ko','LineWidth',1.8,'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',10.0);
plot(lambda_0,unstable_points,'--ko','LineWidth',1.8,'MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',10.0);
% plot the lambda-axis.
plot(lambda_axis,zeros(1,length(lambda_axis)),'-b','LineWidth',1.8);
% plot the xo-axis.
plot(zeros(1,length(xo_axis)),xo_axis,'-b','LineWidth',1.8);
xlabel('lambda');
ylabel('xo');
grid on
hold off