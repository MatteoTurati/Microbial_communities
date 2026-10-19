% Simulations of the estimated gLV models and figures of the paper:
%   MINIMAL section   -> Figure 3 (probiotic consortium, minimal approach)
%   SUBSYSTEM section -> Figure 4 (probiotic consortium, subsystem approach),
%                        Figure 6 (four-strain (Core) community), Figure 7 (seven-strain community)
%   HEATMAPS section  -> Figure 5 (interaction matrix)
% Species: 1. LP, 2. LA, 3. BL, 4. CO, 5. CS, 6. BC, 7. EC

% Settings
% Community : figures generated in each section
%             "Two"        -> co-cultures S12, S13, S23
%             "Probiotics" -> S123 (Figure 3 in MINIMAL, Figure 4 in SUBSYSTEM)
%             "Four"       -> S4 (Figure 6, SUBSYSTEM only)
%             "Seven"      -> S7 (Figure 7, SUBSYSTEM only)
%             "All"        -> all of the above
% Scale     : "Log" (log y-axis, limits 5e4-1e10) or any other value for linear
% tspan     : simulation time grid [h] 
% -------------------------------------------------

%% READING THE EXPERIMENTAL DATA

clc; clear; close all;

S_cocolture = readtable('Data/Tabella_S2_rev.xlsx');
S_cocolture.Co_colture = string(S_cocolture.Co_colture);
S_cocolture.Species = string(S_cocolture.Species);
S_cocolture.Time = string(S_cocolture.Time);
S_cocolture.Properties.VariableNames{'MeanBacterialCounts_cellsML_1_'} = 'Measurements';

S_threespecies = readtable('Data/Tabella_S3_rev.xlsx');
S_threespecies.Species = string(S_threespecies.Species);
S_threespecies.Time = string(S_threespecies.Time);
S_threespecies.Properties.VariableNames{'MeanBacterialCounts_cellsML_1_'} = 'Measurements';

S_fourspecies = readtable('Data/Tabella_S4_rev.xlsx');
S_fourspecies.Species = string(S_fourspecies.Species);
S_fourspecies.Time = string(S_fourspecies.Time);
S_fourspecies.Properties.VariableNames{'MeanBacterialCounts_cellsML_1_'} = 'Measurements';

S_sevenspecies = readtable('Data/Tabella_S5_rev.xlsx');
S_sevenspecies.Species = string(S_sevenspecies.Species);
S_sevenspecies.Time = string(S_sevenspecies.Time);
S_sevenspecies.Properties.VariableNames{'MeanBacterialCounts_cellsML_1_'} = 'Measurements';

Time = [0; 8; 16; 24; 32; 48];

Time_S12 = table( ...
    Time, ...
    S_cocolture.Measurements(S_cocolture.Co_colture == "LP vs LA" & S_cocolture.Species == "LP"), ...
    S_cocolture.SE(S_cocolture.Co_colture == "LP vs LA" & S_cocolture.Species == "LP"), ...
    S_cocolture.Measurements(S_cocolture.Co_colture == "LP vs LA" & S_cocolture.Species == "LA"), ...
    S_cocolture.SE(S_cocolture.Co_colture == "LP vs LA" & S_cocolture.Species == "LA"), ...
    'VariableNames', {'Time','LP_mean','LP_SE','LA_mean','LA_SE'});

Time_S13 = table( ...
    Time, ...
    S_cocolture.Measurements(S_cocolture.Co_colture == "LP vs BL" & S_cocolture.Species == "LP"), ...
    S_cocolture.SE(S_cocolture.Co_colture == "LP vs BL" & S_cocolture.Species == "LP"), ...
    S_cocolture.Measurements(S_cocolture.Co_colture == "LP vs BL" & S_cocolture.Species == "BL"), ...
    S_cocolture.SE(S_cocolture.Co_colture == "LP vs BL" & S_cocolture.Species == "BL"), ...
    'VariableNames', {'Time','LP_mean','LP_SE','BL_mean','BL_SE'});

Time_S23 = table( ...
    Time, ...
    S_cocolture.Measurements(S_cocolture.Co_colture == "LA vs BL" & S_cocolture.Species == "LA"), ...
    S_cocolture.SE(S_cocolture.Co_colture == "LA vs BL" & S_cocolture.Species == "LA"), ...
    S_cocolture.Measurements(S_cocolture.Co_colture == "LA vs BL" & S_cocolture.Species == "BL"), ...
    S_cocolture.SE(S_cocolture.Co_colture == "LA vs BL" & S_cocolture.Species == "BL"), ...
    'VariableNames', {'Time','LA_mean','LA_SE','BL_mean','BL_SE'});

Time_S123 = table( ...
    Time, ...
    S_threespecies.Measurements(S_threespecies.Species == "LP"), ...
    S_threespecies.SE(S_threespecies.Species == "LP"), ...
    S_threespecies.Measurements(S_threespecies.Species == "LA"), ...
    S_threespecies.SE(S_threespecies.Species == "LA"), ...
    S_threespecies.Measurements(S_threespecies.Species == "BL"), ...
    S_threespecies.SE(S_threespecies.Species == "BL"), ...
    'VariableNames', ...
    {'Time','LP_mean','LP_SE','LA_mean','LA_SE','BL_mean','BL_SE'});

Time_S4 = table( ...
    Time, ...
    S_fourspecies.Measurements(S_fourspecies.Species == "CO"), ...
    S_fourspecies.SE(S_fourspecies.Species == "CO"), ...
    S_fourspecies.Measurements(S_fourspecies.Species == "CS"), ...
    S_fourspecies.SE(S_fourspecies.Species == "CS"), ...
    S_fourspecies.Measurements(S_fourspecies.Species == "BC"), ...
    S_fourspecies.SE(S_fourspecies.Species == "BC"), ...
    S_fourspecies.Measurements(S_fourspecies.Species == "EC"), ...
    S_fourspecies.SE(S_fourspecies.Species == "EC"), ...
    'VariableNames', ...
    {'Time','CO_mean','CO_SE','CS_mean','CS_SE', ...
     'BC_mean','BC_SE','EC_mean','EC_SE'});

Time_S7 = table( ...
    Time, ...
    S_sevenspecies.Measurements(S_sevenspecies.Species == "LP"), ...
    S_sevenspecies.SE(S_sevenspecies.Species == "LP"), ...
    S_sevenspecies.Measurements(S_sevenspecies.Species == "LA"), ...
    S_sevenspecies.SE(S_sevenspecies.Species == "LA"), ...
    S_sevenspecies.Measurements(S_sevenspecies.Species == "BL"), ...
    S_sevenspecies.SE(S_sevenspecies.Species == "BL"), ...
    S_sevenspecies.Measurements(S_sevenspecies.Species == "CO"), ...
    S_sevenspecies.SE(S_sevenspecies.Species == "CO"), ...
    S_sevenspecies.Measurements(S_sevenspecies.Species == "CS"), ...
    S_sevenspecies.SE(S_sevenspecies.Species == "CS"), ...
    S_sevenspecies.Measurements(S_sevenspecies.Species == "BC"), ...
    S_sevenspecies.SE(S_sevenspecies.Species == "BC"), ...
    S_sevenspecies.Measurements(S_sevenspecies.Species == "EC"), ...
    S_sevenspecies.SE(S_sevenspecies.Species == "EC"), ...
    'VariableNames', ...
    {'Time','LP_mean','LP_SE','LA_mean','LA_SE','BL_mean','BL_SE', ...
     'CO_mean','CO_SE','CS_mean','CS_SE','BC_mean','BC_SE','EC_mean','EC_SE'});

%% MINIMAL - parameters from the minimal approach (Figure 3)

Community = "Probiotics";
Scale = "Log";

tspan = 0:0.001:50;

species = ["LP","LA","BL","CO","CS","BC","EC"];

gamma = [ ...
    1.1151e-09;      
    4.3136e-11;      
    4.9436e-10;     
    ];    

r = [ ...            
    0.1604;     
    0.1011;         
    0.1280;        
    ];       

A = [ ...            
    0 1.5829e-10  -1.6988e-10;  
   -5.0273e-10 0 -2.6158e-10; 
   -7.7706e-10 1.2504e-08 0; 
   ];

x0_S12 = [ ...
    1.2082e6; 
    7.1827e6];

x0_S13 = [ ...
    1.7174e6;
    5.14e5]; 

x0_S23 = [ ...
    4.5371e5;
    8.1591e5]; 

x0_S123 = [ ...
    0.6426e6;  
    1.0071e5;   
    1.0893e6];

if Community == "Two" || Community == "All"

    pair_indices = {[1 2],[1 3],[2 3]};
    pair_tables = {Time_S12,Time_S13,Time_S23};
    pair_names = {["LP","LA"],["LP","BL"],["LA","BL"]};
    pair_titles = ["LP + LA","LP + BL","LA + BL"];
    pair_x0 = {x0_S12,x0_S13,x0_S23};

    figure
    clf

    for k = 1:3

        ind = pair_indices{k};
        Dati = pair_tables{k};
        names = pair_names{k};
        x0 = pair_x0{k};

        r_sub = r(ind);
        A_sub = A(ind,ind);
        gamma_sub = gamma(ind);

        [t_model,x_model] = ode45( ...
            @(t,x) Ode_community(t,x,r_sub,A_sub,gamma_sub), ...
            tspan,x0);

        for i = 1:2

            subplot(3,2,(k-1)*2+i)

            if Scale == "Log"
                semilogy(t_model,x_model(:,i),'LineWidth',2)
                ylim([5e4 1e10])
                yticks(10.^(5:10))
            else
                plot(t_model,x_model(:,i),'LineWidth',2)
            end

            hold on

            plot( ...
                 Dati.Time, ...
                 Dati.(names(i)+"_mean"), ...
                 'ko','MarkerFaceColor','k')

            title(names(i))
            xlabel('Time [h]')
            ylabel('Cells/mL')
            grid on

        end

    end  

ax_title = axes(gcf, ...
    'Position',[0 0 1 1], ...
    'Visible','off', ...
    'HitTest','off');

text(ax_title,0.51,0.95,'Coculture LP + LA', ...
    'Units','normalized', ...
    'HorizontalAlignment','center', ...
    'FontWeight','bold', ...
    'FontSize',15);

text(ax_title,0.51,0.65,'Coculture LP + BL', ...
    'Units','normalized', ...
    'HorizontalAlignment','center', ...
    'FontWeight','bold', ...
    'FontSize',15);

text(ax_title,0.51,0.35,'Coculture LA + BL', ...
    'Units','normalized', ...
    'HorizontalAlignment','center', ...
    'FontWeight','bold', ...
    'FontSize',15);

end

if Community == "Probiotics" || Community == "All"

    ind = 1:3;
    names = species(ind);

    [t_model,x_model] = ode45( ...
        @(t,x) Ode_community(t,x,r(ind),A(ind,ind),gamma(ind)), ...
        tspan,x0_S123);

    figure
    clf

    for i = 1:3

        ax = subplot(3,2,2*i-1);  

        if Scale == "Log"
            semilogy(t_model,x_model(:,i),'LineWidth',2)
            ylim([5e4 1e10])
            yticks(10.^(5:10))
        else
            plot(t_model,x_model(:,i),'LineWidth',2)
        end

        hold on
        
        plot( ...
             Time_S123.Time, ...
             Time_S123.(names(i)+"_mean"), ...
             'ko','MarkerFaceColor','k')

        title(names(i))
        xlabel('Time [h]')
        ylabel('Cells/mL')
        grid on

    end

    xc = ax.Position(1) + ax.Position(3)/2;      

    annotation('textbox',[xc-0.15 0.95 0.30 0.04], ...
     'String','Probiotic community', ...
     'EdgeColor','none', ...
     'HorizontalAlignment','center', ...
     'FontWeight','bold', ...
     'FontSize',15);
end

% Stability 

a12_tilde = A(1,2)./gamma(1); 
a13_tilde = A(1,3)./gamma(1);

a21_tilde = A(2,1)./gamma(2);
a23_tilde = A(2,3)./gamma(2);

a31_tilde = A(3,1)./gamma(3);
a32_tilde = A(3,2)./gamma(3);

r1_tilde = r(1)./gamma(1);
r2_tilde = r(2)./gamma(2);
r3_tilde = r(3)./gamma(3);

Det_12 = 1 - a12_tilde*a21_tilde;
Eq_12(1) = (r1_tilde + a12_tilde* r2_tilde)/Det_12;
Eq_12(2) = (r2_tilde + a21_tilde* r1_tilde)/Det_12;

Det_13 = 1 - a13_tilde*a31_tilde;
Eq_13(1) = (r1_tilde + a13_tilde* r3_tilde)/Det_13;
Eq_13(2) = (r3_tilde + a31_tilde* r1_tilde)/Det_13;

Det_23 = 1 - a23_tilde*a32_tilde;
Eq_23(1) = (r2_tilde + a23_tilde* r3_tilde)/Det_23;
Eq_23(2) = (r3_tilde + a32_tilde* r2_tilde)/Det_23;

[stability_3, feasibility_3, x_eq_3, eig_J_3] = stability(r,A,gamma);
disp("---------------------------------------------------------------------------------")

%% SUBSYSTEM - probiotic parameters from the subsystem approach and
%  core parameters from the S4/S7 fit (Figures 4, 6, 7)

Community = "Seven";
Scale = "Log";

tspan = 0:0.001:50;

species = ["LP","LA","BL","CO","CS","BC","EC"];

gamma = [ ...
    3.1518e-10;     
    8.1217e-11;      
    5.0028e-10;   
    1.21219e-8;     
    2.44346e-08;    
    3.70796e-08;     
    7.36490e-9];   

r = [ ...           
    0.1465;         
    0.0775;         
    0.1127;        
    0.141987;       
    0.996846;       
    0.637444;       
    3.08313];    

A = [ ...           
    0            8.7692e-11  -2.2974e-10  -1.87577e-11   1.73916e-11  -3.67212e-11  -1.04057e-11 ;
   -1.0891e-10   0           -2.1017e-10  -6.77768e-12  -5.47409e-11  -7.8252e-11    4.71969e-11 ;
   -7.9004e-11   1.2749e-08   0            2.18708e-11   1.03998e-10   4.20072e-11   1.0792e-10  ;
   -1.67717e-10 -8.40063e-11 -5.83272e-11  0            1.33585e-10   3.47399e-10  -6.43784e-11 ;
   -3.33283e-11 -5.47406e-11 -9.70968e-11  1.21204e-10   0            1.31568e-10  -2.35983e-09 ;
   -1.05338e-09  5.36007e-10 -3.69644e-10  7.85531e-11  -4.46502e-10   0           -2.68841e-10 ;
   -3.43579e-09  5.57818e-10 -1.21324e-09  1.28874e-10   1.00213e-10   2.97515e-10   0          ];

x0_S4 = [ ...        
    2.02286e+06; 
    2.82024e+06;
    6.69303e+06;
    2.11883e+07];

x0_S7 = [ ...       
    1.86424e+06;
    4.64747e+05;
    8.55956e+05;
    4.19399e+05;  
    3.14090e+05;   
    1.43193e+07;
    2.32e+07]; 

x0_S12 = [ ...
    1.3951e6;
    7.60001e6];

x0_S13 = [ ...
    1.4281e6;
    5.1750e5];

x0_S23 = [ ...
    4.4880e5;
    9.2020e5];

x0_S123 = [ ...
    7.5859e5;
    9.7158e4; 
    1.2350e6];

if Community == "Two" || Community == "All"

    pair_indices = {[1 2],[1 3],[2 3]};
    pair_tables = {Time_S12,Time_S13,Time_S23};
    pair_names = {["LP","LA"],["LP","BL"],["LA","BL"]};
    pair_titles = ["LP + LA","LP + BL","LA + BL"];
    pair_x0 = {x0_S12,x0_S13,x0_S23};

    figure
    clf

    for k = 1:3

        ind = pair_indices{k};
        Dati = pair_tables{k};
        names = pair_names{k};
        x0 = pair_x0{k};

        r_sub = r(ind);
        A_sub = A(ind,ind);
        gamma_sub = gamma(ind);

        [t_model,x_model] = ode45( ...
            @(t,x) Ode_community(t,x,r_sub,A_sub,gamma_sub), ...
            tspan,x0);

        for i = 1:2

            subplot(3,2,(k-1)*2+i)

            if Scale == "Log"
                semilogy(t_model,x_model(:,i),'LineWidth',2)
                ylim([5e4 1e10])
                yticks(10.^(5:10))
            else
                plot(t_model,x_model(:,i),'LineWidth',2)
            end

            hold on

            plot( ...
                 Dati.Time, ...
                 Dati.(names(i)+"_mean"), ...
                 'ko','MarkerFaceColor','k')

            title(names(i))
            xlabel('Time [h]')
            ylabel('Cells/mL')
            grid on

        end

    end  

ax_title = axes(gcf, ...
    'Position',[0 0 1 1], ...
    'Visible','off', ...
    'HitTest','off');

text(ax_title,0.51,0.95,'Coculture LP + LA', ...
    'Units','normalized', ...
    'HorizontalAlignment','center', ...
    'FontWeight','bold', ...
    'FontSize',15);

text(ax_title,0.51,0.65,'Coculture LP + BL', ...
    'Units','normalized', ...
    'HorizontalAlignment','center', ...
    'FontWeight','bold', ...
    'FontSize',15);

text(ax_title,0.51,0.35,'Coculture LA + BL', ...
    'Units','normalized', ...
    'HorizontalAlignment','center', ...
    'FontWeight','bold', ...
    'FontSize',15);

end

if Community == "Probiotics" || Community == "All"

    ind = 1:3;
    names = species(ind);

    [t_model,x_model] = ode45( ...
        @(t,x) Ode_community(t,x,r(ind),A(ind,ind),gamma(ind)), ...
        tspan,x0_S123);

    figure
    clf

    for i = 1:3

        ax = subplot(3,2,2*i-1);

        if Scale == "Log"
            semilogy(t_model,x_model(:,i),'LineWidth',2)
            ylim([5e4 1e10])
            yticks(10.^(5:10))
        else
            plot(t_model,x_model(:,i),'LineWidth',2)
        end

        hold on
        
        plot( ...
             Time_S123.Time, ...
             Time_S123.(names(i)+"_mean"), ...
             'ko','MarkerFaceColor','k')

        title(names(i))
        xlabel('Time [h]')
        ylabel('Cells/mL')
        grid on

    end

   xc = ax.Position(1) + ax.Position(3)/2;      

   annotation('textbox',[xc-0.15 0.95 0.30 0.04], ...
     'String','Probiotic community', ...
     'EdgeColor','none', ...
     'HorizontalAlignment','center', ...
     'FontWeight','bold', ...
     'FontSize',15);
end

if Community == "Four" || Community == "All"

    ind = 4:7;
    names = species(ind);

    [t_model,x_model] = ode45( ...
        @(t,x) Ode_community(t,x,r(ind),A(ind,ind),gamma(ind)), ...
        tspan,x0_S4);

    figure
    clf

    for i = 1:4

        subplot(2,2,i)

        if Scale == "Log"
            semilogy(t_model,x_model(:,i),'LineWidth',2)
            ylim([5e4 1e10])
            yticks(10.^(5:10))
        else
            plot(t_model,x_model(:,i),'LineWidth',2)
        end

        hold on

        plot( ...
             Time_S4.Time, ...
             Time_S4.(names(i)+"_mean"), ...
             'ko','MarkerFaceColor','k')
        
        title(names(i))
        xlabel('Time [h]')
        ylabel('Cells/mL')
        grid on

    end

    annotation('textbox',[0.37 0.95 0.30 0.04], ...
    'String','Four-species community', ...
    'EdgeColor','none', ...
    'HorizontalAlignment','center', ...
    'FontWeight','bold', ...
    'FontSize',15);

end

if Community == "Seven" || Community == "All"

    names = species;

    [t_model,x_model] = ode45( ...
        @(t,x) Ode_community(t,x,r,A,gamma), ...
        tspan,x0_S7);

    figure
    clf

    for i = 1:7

        subplot(4,2,i)

        if Scale == "Log"
            semilogy(t_model,x_model(:,i),'LineWidth',2)
            ylim([5e4 1e10])
            yticks(10.^(5:10))
        else
            plot(t_model,x_model(:,i),'LineWidth',2)
        end

        hold on
        
        plot( ...
             Time_S7.Time, ...
             Time_S7.(names(i)+"_mean"), ...
             'ko','MarkerFaceColor','k')

        title(names(i))
        xlabel('Time [h]')
        ylabel('Cells/mL')
        grid on

    end

    annotation('textbox',[0.37 0.95 0.30 0.04], ...
    'String','Seven-species community', ...
    'EdgeColor','none', ...
    'HorizontalAlignment','center', ...
    'FontWeight','bold', ...
    'FontSize',15);

end

% Stability

a12_tilde = A(1,2)./gamma(1); 
a13_tilde = A(1,3)./gamma(1);

a21_tilde = A(2,1)./gamma(2);
a23_tilde = A(2,3)./gamma(2);

a31_tilde = A(3,1)./gamma(3);
a32_tilde = A(3,2)./gamma(3);

r1_tilde = r(1)./gamma(1);
r2_tilde = r(2)./gamma(2);
r3_tilde = r(3)./gamma(3);

Det_12 = 1 - a12_tilde*a21_tilde;
Eq_12(1) = (r1_tilde + a12_tilde* r2_tilde)/Det_12;
Eq_12(2) = (r2_tilde + a21_tilde* r1_tilde)/Det_12;

Det_13 = 1 - a13_tilde*a31_tilde;
Eq_13(1) = (r1_tilde + a13_tilde* r3_tilde)/Det_13;
Eq_13(2) = (r3_tilde + a31_tilde* r1_tilde)/Det_13;

Det_23 = 1 - a23_tilde*a32_tilde;
Eq_23(1) = (r2_tilde + a23_tilde* r3_tilde)/Det_23;
Eq_23(2) = (r3_tilde + a32_tilde* r2_tilde)/Det_23;

[stability_3, feasibility_3, x_eq_3, eig_J_3] = stability(r(1:3),A(1:3,1:3),gamma(1:3));
disp("---------------------------------------------------------------------------------")
[stability_4, feasibility_4, x_eq_4, eig_J_4] = stability(r(4:7),A(4:7,4:7),gamma(4:7));
disp("---------------------------------------------------------------------------------")
[stability_7, feasibility_7, x_eq_7, eig_J_7] = stability(r,A,gamma);

%% HEATMAPS - interaction matrix A - diag(gamma) (Figure 5)
% Rows: affected strain i; columns: acting strain j; diagonal: -gamma_i

names = {'LP','LA','BL','CO','CS','BC','EC'};

A = [ ...
   -3.1518e-10   8.7692e-11  -2.2974e-10  -1.87577e-11   1.73916e-11  -3.67212e-11  -1.04057e-11;
   -1.0891e-10  -8.1217e-11  -2.1017e-10  -6.77768e-12  -5.47409e-11  -7.8252e-11    4.71969e-11;
   -7.9004e-11   1.2749e-08  -5.0028e-10   2.18708e-11   1.03998e-10   4.20072e-11    1.0792e-10;
   -1.67717e-10 -8.40063e-11 -5.83272e-11 -1.21219e-08   1.33585e-10   3.47399e-10   -6.43784e-11;
   -3.33283e-11 -5.47406e-11 -9.70968e-11  1.21204e-10  -2.44346e-08   1.31568e-10   -2.35983e-09;
   -1.05338e-09  5.36007e-10 -3.69644e-10  7.85531e-11  -4.46502e-10  -3.70796e-08   -2.68841e-10;
   -3.43579e-09  5.57818e-10 -1.21324e-09  1.28874e-10   1.00213e-10   2.97515e-10   -7.36490e-09];

n = size(A,1);

absA = abs(A);
absA(absA==0) = NaN;

L = log10(absA);
Lmin = min(L(:),[],'omitnan');

mag = L - Lmin;
mag(~isfinite(mag)) = 0;

M = sign(A).*mag;

maxMag = max(mag(:));
cLimits = [-maxMag maxMag];

fig = figure('Color','w','Units','centimeters','Position',[2 2 16 14]);
ax = axes(fig);

imagesc(ax,M)
axis(ax,'image')

xlim(ax,[0.5 n+0.5])
ylim(ax,[0.5 n+0.5])

ax.XTick = 1:n;
ax.YTick = 1:n;
ax.XTickLabel = names;
ax.YTickLabel = names;

xtickangle(ax,45)

ax.TickDir = 'out';
ax.LineWidth = 1.0;
ax.FontName = 'Arial';
ax.FontSize = 14;
ax.Box = 'on';

xlabel(ax,'Acting strain (j)','FontName','Arial','FontSize',16)
ylabel(ax,'Affected strain (i)','FontName','Arial','FontSize',16)

colormap(fig,blueWhiteRed(256))
clim(ax,cLimits)

hold(ax,'on')
for k = 0.5:1:(n+0.5)
    xline(ax,k,'-','Color',[0 0 0],'LineWidth',0.35,'Alpha',0.35);
    yline(ax,k,'-','Color',[0 0 0],'LineWidth',0.35,'Alpha',0.35);
end
hold(ax,'off')

cb = colorbar(ax);
cb.TickDirection = 'out';
cb.FontName = 'Arial';
cb.FontSize = 10;

tmax = floor(maxMag);
tickStep = 1;
ticks = 0:tickStep:tmax;

if maxMag - ticks(end) > 0.3
    ticks = [ticks maxMag];
end

cb.Ticks = [-fliplr(ticks(2:end)) 0 ticks(2:end)];
cb.Limits = cLimits;

tickLabels = strings(size(cb.Ticks));
for i = 1:numel(cb.Ticks)
    v = cb.Ticks(i);
    if v == 0
        tickLabels(i) = "\pm10^{" + num2str(round(Lmin)) + "}";
    else
        expo = Lmin + abs(v);
        if abs(abs(v) - maxMag) < 1e-12         
            e = floor(expo);
            mant = 10^(expo - e);
            lab = sprintf('%.1f\\times10^{%d}', mant, e);
        else
            lab = "10^{" + num2str(round(expo)) + "}";
        end
        if v < 0
            tickLabels(i) = "-" + lab;
        else
            tickLabels(i) = "+" + lab;
        end
    end
end

cb.TickLabels = tickLabels;
cb.TickLabelInterpreter = 'tex';
cb.FontSize = 14;

ylabel(cb,'a_{ij} (mL cell^{-1} h^{-1}), signed log scale','FontName','Arial','FontSize',16)

function cmap = blueWhiteRed(m)
if nargin < 1
    m = 256;
end
m = max(3,round(m));
m1 = floor(m/2);
m2 = m - m1;
b2w = [linspace(0,1,m1)', linspace(0,1,m1)', ones(m1,1)];
w2r = [ones(m2,1), linspace(1,0,m2)', linspace(1,0,m2)'];
cmap = [b2w; w2r];
end



