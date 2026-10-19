% Robustness of pairwise stability and feasibility of the probiotic co-cultures (subsystem-approach parameters)
% "Parameter sensitivity" section        -> magnitudes ofa_ij_tilde, a_ji_tilde rescaled by 0.01-100x, 
%                                           signs preserved
% "Stability and feasibility robustness" ->  coefficients varied over +/-10x the estimates,
%                                            sign changes included

% For each pair: Det = 1 - a_ij_tilde*a_ji_tilde (stability if Det > 0),
% equilibrium X* from the normalized parameters (feasibility if X* > 0)

% Colours: green = stable and feasible, 
%          orange = unstable and unfeasible,
%          purple = stable but unfeasible, 
%          grey = unstable but feasible,  
%          blue = estimated parameters

% Species: 1 LP, 2 LA, 3 BL
% S12 LP + LA: (a12_tilde, a21_tilde)
% S13 LP + BL: (a13_tilde, a31_tilde)
% S23 LA + BL: (a23_tilde, a32_tilde)

%% Parameters
% Normalized parameters: a_ij_tilde = a_ij/gamma_i, r_i_tilde = r_i/gamma_i
clc; close all; clear;

gamma = [ ...
    3.1518e-10;      
    8.1217e-11;     
    5.0028e-10;     
];    

r = [ ...           
    0.1465;         
    0.0775;          
    0.1127;          
];        

A = [ ...            
    0            8.7692e-11  -2.2974e-10;
   -1.0891e-10   0           -2.1017e-10;
   -7.9004e-11   1.2749e-08   0;
     ];

a12_tilde = A(1,2)./gamma(1); 
a13_tilde = A(1,3)./gamma(1);

a21_tilde = A(2,1)./gamma(2);
a23_tilde = A(2,3)./gamma(2);

a31_tilde = A(3,1)./gamma(3);
a32_tilde = A(3,2)./gamma(3);

r1_tilde = r(1)./gamma(1);
r2_tilde = r(2)./gamma(2);
r3_tilde = r(3)./gamma(3);

%% Parameter strenght sensitivity
% Both interaction coefficients of each pair are multiplied by factors in [1e-2, 1e2] (log grid, 250x250)
% r_tilde is fixed

green_col  = [0.20 0.55 0.29];
red_col    = [0.80 0.33 0.00];
purple_col = [0.49 0.18 0.56];
black_col  = [0.78 0.78 0.80];
blue_col   = [0.00 0.36 0.62];

factors = logspace(-2,2,250);

% LP LA
figure(1)
Fx = factors;
Fy = factors;

[Xf,Yf] = meshgrid(Fx,Fy);
X = a12_tilde .* Xf;
Y = a21_tilde .* Yf;

Det = 1 - X .* Y;
X1_eq = (r1_tilde + X .* r2_tilde) ./ Det;
X2_eq = (r2_tilde + Y .* r1_tilde) ./ Det;

Feas = (X1_eq > 0) & (X2_eq > 0) & isfinite(X1_eq) & isfinite(X2_eq);
StableRaw = (Det > 0);

SF = StableRaw & Feas;
UU = ~StableRaw & ~Feas;
SU = StableRaw & ~Feas;
UF = ~StableRaw & Feas;

hold on
scatter(Xf(SF),Yf(SF),18,green_col,'filled','MarkerFaceAlpha',0.75,'MarkerEdgeAlpha',0.75,'DisplayName','Stable and feasible')
scatter(Xf(UU),Yf(UU),18,red_col,'filled','MarkerFaceAlpha',0.75,'MarkerEdgeAlpha',0.75,'DisplayName','Unstable and unfeasible')
scatter(Xf(SU),Yf(SU),18,purple_col,'filled','MarkerFaceAlpha',0.75,'MarkerEdgeAlpha',0.75,'DisplayName','Stable but unfeasible')
scatter(Xf(UF),Yf(UF),18,black_col,'filled','MarkerFaceAlpha',0.75,'MarkerEdgeAlpha',0.75,'DisplayName','Unstable but feasible')
scatter(1,1,90,blue_col,'filled','MarkerEdgeColor','k','LineWidth',0.8,'DisplayName','Starting point')
set(gca,'XScale','log','YScale','log','FontSize',12,'LineWidth',1,'Box','on')
xlabel('$\tilde{a}_{12}/\tilde{a}_{12}^{(0)}$','Interpreter','latex','FontSize',22)
ylabel('$\tilde{a}_{21}/\tilde{a}_{21}^{(0)}$','Interpreter','latex','FontSize',22)
title('LP + LA','FontSize',22)
xlim([1e-2 1e2])
ylim([1e-2 1e2])

ax = gca;

ax.XScale = 'log';
ax.YScale = 'log';

ax.Box = 'off';
ax.XAxisLocation = 'bottom';
ax.YAxisLocation = 'left';

ax.XColor = [0 0 0];
ax.YColor = [0 0 0];

ax.LineWidth = 1.5;

ax.TickDir = 'out';
ax.TickLength = [0.02 0.02];

hold off

% LP BL
figure(2)
Fx = factors;
Fy = factors;

[Xf,Yf] = meshgrid(Fx,Fy);
X = a13_tilde .* Xf;
Y = a31_tilde .* Yf;

Det = 1 - X .* Y;
X1_eq = (r1_tilde + X .* r3_tilde) ./ Det;
X3_eq = (r3_tilde + Y .* r1_tilde) ./ Det;

Feas = (X1_eq > 0) & (X3_eq > 0) & isfinite(X1_eq) & isfinite(X3_eq);
StableRaw = (Det > 0);

SF = StableRaw & Feas;
UU = ~StableRaw & ~Feas;
SU = StableRaw & ~Feas;
UF = ~StableRaw & Feas;

hold on
scatter(Xf(SF),Yf(SF),18,green_col,'filled','MarkerFaceAlpha',0.75,'MarkerEdgeAlpha',0.75,'DisplayName','Stable and feasible')
scatter(Xf(UU),Yf(UU),18,red_col,'filled','MarkerFaceAlpha',0.75,'MarkerEdgeAlpha',0.75,'DisplayName','Unstable and unfeasible')
scatter(Xf(SU),Yf(SU),18,purple_col,'filled','MarkerFaceAlpha',0.75,'MarkerEdgeAlpha',0.75,'DisplayName','Stable but unfeasible')
scatter(Xf(UF),Yf(UF),18,black_col,'filled','MarkerFaceAlpha',0.75,'MarkerEdgeAlpha',0.75,'DisplayName','Unstable but feasible')
scatter(1,1,90,blue_col,'filled','MarkerEdgeColor','k','LineWidth',0.8,'DisplayName','Starting point')
set(gca,'XScale','log','YScale','log','FontSize',12,'LineWidth',1,'Box','on')
xlabel('$\tilde{a}_{13}/\tilde{a}_{13}^{(0)}$','Interpreter','latex','FontSize',22)
ylabel('$\tilde{a}_{31}/\tilde{a}_{31}^{(0)}$','Interpreter','latex','FontSize',22)
title('LP + BL','FontSize',22)
xlim([1e-2 1e2])
ylim([1e-2 1e2])

ax = gca;

ax.XScale = 'log';
ax.YScale = 'log';

ax.Box = 'off';
ax.XAxisLocation = 'bottom';
ax.YAxisLocation = 'left';

ax.XColor = [0 0 0];
ax.YColor = [0 0 0];

ax.LineWidth = 1.5;

ax.TickDir = 'out';
ax.TickLength = [0.02 0.02];

hold off

% LA BL
figure(3)
Fx = factors;
Fy = factors;

[Xf,Yf] = meshgrid(Fx,Fy);
X = a23_tilde .* Xf;
Y = a32_tilde .* Yf;

Det = 1 - X .* Y;
X2_eq = (r2_tilde + X .* r3_tilde) ./ Det;
X3_eq = (r3_tilde + Y .* r2_tilde) ./ Det;

Feas = (X2_eq > 0) & (X3_eq > 0) & isfinite(X2_eq) & isfinite(X3_eq);
StableRaw = (Det > 0);

SF = StableRaw & Feas;
UU = ~StableRaw & ~Feas;
SU = StableRaw & ~Feas;
UF = ~StableRaw & Feas;

hold on
scatter(Xf(SF),Yf(SF),18,green_col,'filled','MarkerFaceAlpha',0.75,'MarkerEdgeAlpha',0.75,'DisplayName','Stable and feasible')
scatter(Xf(UU),Yf(UU),18,red_col,'filled','MarkerFaceAlpha',0.75,'MarkerEdgeAlpha',0.75,'DisplayName','Unstable and unfeasible')
scatter(Xf(SU),Yf(SU),18,purple_col,'filled','MarkerFaceAlpha',0.75,'MarkerEdgeAlpha',0.75,'DisplayName','Stable but unfeasible')
scatter(Xf(UF),Yf(UF),18,black_col,'filled','MarkerFaceAlpha',0.75,'MarkerEdgeAlpha',0.75,'DisplayName','Unstable but feasible')
scatter(1,1,90,blue_col,'filled','MarkerEdgeColor','k','LineWidth',0.8,'DisplayName','Starting point')
set(gca,'XScale','log','YScale','log','FontSize',12,'LineWidth',1,'Box','on')
xlabel('$\tilde{a}_{23}/\tilde{a}_{23}^{(0)}$','Interpreter','latex','FontSize',22)
ylabel('$\tilde{a}_{32}/\tilde{a}_{32}^{(0)}$','Interpreter','latex','FontSize',22)
title('LA + BL','FontSize',22)
xlim([1e-2 1e2])
ylim([1e-2 1e2])

ax = gca;

ax.XScale = 'log';
ax.YScale = 'log';

ax.Box = 'off';
ax.XAxisLocation = 'bottom';
ax.YAxisLocation = 'left';

ax.XColor = [0 0 0];
ax.YColor = [0 0 0];

ax.LineWidth = 1.5;

ax.TickDir = 'out';
ax.TickLength = [0.02 0.02];

hold off


%% Sign robustness
% Coefficients varied linearly from -10x to +10x the estimates (1000x1000 grid), allowing sign changes
% r_tilde is fixed

green_col  = [0.20 0.55 0.29];
red_col    = [0.80 0.33 0.00];
purple_col = [0.49 0.18 0.56];
black_col  = [0.78 0.78 0.80];
blue_col   = [0.00 0.36 0.62];

% LP LA

figure(1)
clf

xlabel('$\tilde{a}_{12}$','Interpreter','latex','FontSize',22)
ylabel('$\tilde{a}_{21}$','Interpreter','latex','FontSize',22)
title('LP + LA','FontSize',22)

factors = linspace(-10,10,1000);

A_12 = a12_tilde*factors;
A_21 = a21_tilde*factors;

[X,Y] = meshgrid(A_12,A_21);

Det = 1 - X.*Y;

X1_eq = (r1_tilde + X.*r2_tilde)./Det;
X2_eq = (r2_tilde + Y.*r1_tilde)./Det;

Feas = (X1_eq > 0) & (X2_eq > 0) & isfinite(X1_eq) & isfinite(X2_eq);
Stable_raw = (Det > 0);

SF = Stable_raw & Feas;
UU = ~Stable_raw & ~Feas;
SU = Stable_raw & ~Feas;
UF = ~Stable_raw & Feas;

hold on

scatter(X(SF),Y(SF),12,green_col,'filled', ...
    'MarkerFaceAlpha',0.7,'MarkerEdgeAlpha',0.7)
scatter(X(UU),Y(UU),12,red_col,'filled', ...
    'MarkerFaceAlpha',0.7,'MarkerEdgeAlpha',0.7)
scatter(X(SU),Y(SU),12,purple_col,'filled', ...
    'MarkerFaceAlpha',0.7,'MarkerEdgeAlpha',0.7)
scatter(X(UF),Y(UF),12,black_col,'filled', ...
    'MarkerFaceAlpha',0.7,'MarkerEdgeAlpha',0.7)

scatter(a12_tilde,a21_tilde,80,blue_col,'filled', ...
    'MarkerEdgeColor','k','LineWidth',0.8)

xlim([min(A_12) max(A_12)])
ylim([min(A_21) max(A_21)])

ax = gca;

ax.Box = 'off';
ax.XAxisLocation = 'bottom';
ax.YAxisLocation = 'left';

ax.XColor = [0 0 0];
ax.YColor = [0 0 0];

ax.LineWidth = 1.5;

ax.TickDir = 'out';
ax.TickLength = [0.02 0.02];

grid on
ax = gca;
ax.Layer = 'top';
ax = gca;
ax.Layer = 'top';
ax.GridColor = [0 0 0];   
ax.GridAlpha = 0.05;   
ax.GridLineStyle = '--'; 

axis square
set(gca,'LineWidth',1)

legend({'Stable and feasible', ...
        'Unstable and unfeasible', ...
        'Stable but unfeasible', ...
        'Unstable but feasible', ...
        'Starting point'}, ...
        'Location','best')

hold off

% LP BL

figure(2)
clf

xlabel('$\tilde{a}_{13}$','Interpreter','latex','FontSize',22)
ylabel('$\tilde{a}_{31}$','Interpreter','latex','FontSize',22)
title('LP + BL','FontSize',22)

factors = linspace(-10,10,1000);

A_13 = a13_tilde*factors;
A_31 = a31_tilde*factors;

[X,Y] = meshgrid(A_13,A_31);

Det = 1 - X.*Y;

X1_eq = (r1_tilde + X.*r3_tilde)./Det;
X3_eq = (r3_tilde + Y.*r1_tilde)./Det;

Feas = (X1_eq > 0) & (X3_eq > 0) & isfinite(X1_eq) & isfinite(X3_eq);
Stable_raw = (Det > 0);

SF = Stable_raw & Feas;
UU = ~Stable_raw & ~Feas;
SU = Stable_raw & ~Feas;
UF = ~Stable_raw & Feas;

hold on

scatter(X(SF),Y(SF),12,green_col,'filled', ...
    'MarkerFaceAlpha',0.7,'MarkerEdgeAlpha',0.7)
scatter(X(UU),Y(UU),12,red_col,'filled', ...
    'MarkerFaceAlpha',0.7,'MarkerEdgeAlpha',0.7)
scatter(X(SU),Y(SU),12,purple_col,'filled', ...
    'MarkerFaceAlpha',0.7,'MarkerEdgeAlpha',0.7)
scatter(X(UF),Y(UF),12,black_col,'filled', ...
    'MarkerFaceAlpha',0.7,'MarkerEdgeAlpha',0.7)

scatter(a13_tilde,a31_tilde,80,blue_col,'filled', ...
    'MarkerEdgeColor','k','LineWidth',0.8)

xlim([min(A_13) max(A_13)])
ylim([min(A_31) max(A_31)])

ax = gca;

ax.Box = 'off';
ax.XAxisLocation = 'bottom';
ax.YAxisLocation = 'left';

ax.XColor = [0 0 0];
ax.YColor = [0 0 0];

ax.LineWidth = 1.5;

ax.TickDir = 'out';
ax.TickLength = [0.02 0.02];

grid on
ax = gca;
ax.Layer = 'top';
ax = gca;
ax.Layer = 'top';
ax.GridColor = [0 0 0];   
ax.GridAlpha = 0.05;   
ax.GridLineStyle = '--'; 

axis square
set(gca,'LineWidth',1)

legend({'Stable and feasible', ...
        'Unstable and unfeasible', ...
        'Stable but unfeasible', ...
        'Unstable but feasible', ...
        'Starting point'}, ...
        'Location','best')

hold off


% LA BL

figure(3)
clf

xlabel('$\tilde{a}_{23}$','Interpreter','latex','FontSize',22)
ylabel('$\tilde{a}_{32}$','Interpreter','latex','FontSize',22)
title('LA + BL','FontSize',22)

factors = linspace(-10,10,1000);

A_23 = a23_tilde*factors;
A_32 = a32_tilde*factors;

[X,Y] = meshgrid(A_23,A_32);

Det = 1 - X.*Y;

X2_eq = (r2_tilde + X.*r3_tilde)./Det;
X3_eq = (r3_tilde + Y.*r2_tilde)./Det;

Feas = (X2_eq > 0) & (X3_eq > 0) & isfinite(X2_eq) & isfinite(X3_eq);
Stable_raw = (Det > 0);

SF = Stable_raw & Feas;
UU = ~Stable_raw & ~Feas;
SU = Stable_raw & ~Feas;
UF = ~Stable_raw & Feas;

hold on

scatter(X(SF),Y(SF),12,green_col,'filled', ...
    'MarkerFaceAlpha',0.7,'MarkerEdgeAlpha',0.7)
scatter(X(UU),Y(UU),12,red_col,'filled', ...
    'MarkerFaceAlpha',0.7,'MarkerEdgeAlpha',0.7)
scatter(X(SU),Y(SU),12,purple_col,'filled', ...
    'MarkerFaceAlpha',0.7,'MarkerEdgeAlpha',0.7)
scatter(X(UF),Y(UF),12,black_col,'filled', ...
    'MarkerFaceAlpha',0.7,'MarkerEdgeAlpha',0.7)

scatter(a23_tilde,a32_tilde,80,blue_col,'filled', ...
    'MarkerEdgeColor','k','LineWidth',0.8)

xlim([min(A_23) max(A_23)])
ylim([min(A_32) max(A_32)])

ax = gca;

ax.Box = 'off';
ax.XAxisLocation = 'bottom';
ax.YAxisLocation = 'left';

ax.XColor = [0 0 0];
ax.YColor = [0 0 0];

ax.LineWidth = 1.5;

ax.TickDir = 'out';
ax.TickLength = [0.02 0.02];

grid on
ax = gca;
ax.Layer = 'top';
ax = gca;
ax.Layer = 'top';
ax.GridColor = [0 0 0];   
ax.GridAlpha = 0.05;   
ax.GridLineStyle = '--'; 

axis square
set(gca,'LineWidth',1)

legend({'Stable and feasible', ...
        'Unstable and unfeasible', ...
        'Stable but unfeasible', ...
        'Unstable but feasible', ...
        'Starting point'}, ...
        'Location','best')

hold off