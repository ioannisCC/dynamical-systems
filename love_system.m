classdef love_system
    methods (Static)
        function x = love_or_hate(y, a, b)
        % the values y(1), y(2) are the initial values, and are exctracted
        % from the state vector y which is returmed from the ode45 solver
        % when integrating
        R = y(1);
        J = y(2);
    
        % calculate derivative of R and J w.r.t. t
        dRdt = a * J;
        dJdt = -b * R;
    
        % combine the derivatives into a column vector
        x = [dRdt; dJdt];
        end
    end
end