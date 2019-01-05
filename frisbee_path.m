%physical properties
m = 0.175; %mass (kg)
rho  = 1.225; %density of air (kg/m^3)
g = 9.81; %acceleration due to gravity (m/s^2)
d = 0.27305; %diameter (m)
A = pi*(d/2)^2; %area (m^2)

%velocity and height constraints
beta_deg = 5; %angle to velocity vector
beta_rad = beta_deg * pi / 180;
Vo = 14; %initial velocity (m/s)
Vo_x = Vo*cos(beta_rad);
Vo_y = Vo*sin(beta_rad);
h0 = 1; %initial height

ang_of_att = 45 * pi / 180; %angle of attack
alpha_init = -4 * pi / 180; %initial angle of attack for minimum drag

% drag and lift coefficient parameters
Cd0 = 0.08;
Cdalpha = 2.72;
Cl0 = 0.15;
Clalpha = 1.4;

delta_t = 0.001; %time intervals for Euler's method

%lift coefficient
C_lift = @(ang_att) Cl0 + Clalpha*ang_att;
%drag coefficient
C_drag = @(ang_att) Cd0 + Cdalpha*(ang_att - alpha_init)^2;

CL = C_lift(ang_of_att);
CD = C_drag(ang_of_att);

%vx_arr = zeros(1000);
%vy_arr = zeros(1000);
%x_arr = zeros(1000);
%y_arr = zeros(1000);

vx_arr(1) = Vo_x;
vy_arr(1) = Vo_y;
x_arr(1) = 0;
y_arr(1) = h0;


i = 1;
while y_arr(end) >= 0
    new_x = x_arr(i) + delta_t*vx_arr(i);
    new_y = y_arr(i) + delta_t*vy_arr(i);
    
    new_vx = vx_arr(i) + delta_t*((- CD*vx_arr(i) - CL*vy_arr(i))*sqrt((vx_arr(i))^2 + (vy_arr(i))^2)*rho*A/m/2);
    new_vy = vy_arr(i) + delta_t*(((CL*vx_arr(i) + CD*vy_arr(i))*sqrt((vx_arr(i))^2 + (vy_arr(i))^2)*rho*A/m/2) - g);
    
    i = i + 1;
    vx_arr(i) = new_vx;
    vy_arr(i) = new_vy;
    x_arr(i) = new_x;
    y_arr(i) = new_y;
end

plot(x_arr,y_arr);