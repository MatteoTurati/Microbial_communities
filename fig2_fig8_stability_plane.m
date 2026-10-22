% Generates Figures 2 and 8 of the paper (single culture and
% co-culture stationary data at 48 h only).
%   Figure 8: stability boundary and measured co-culture ratios
%   Figure 2: lognormally perturbed co-culture ratios (stable: dark, unstable: light)

%% READING THE EXPERIMENTAL DATA (single cultures and co-cultures)

clc; close all; clear;

S_monocolture = readtable('Data/Tabella_S1.xlsx');
S_monocolture.Species = string(S_monocolture.Species);
S_monocolture.Time = string(S_monocolture.Time);
S_monocolture.Properties.VariableNames{'MeanBacterialCounts_cellsML_1_'} = 'Measurements';

S_cocolture = readtable('Data/Tabella_S2_rev.xlsx');
S_cocolture.Co_colture = string(S_cocolture.Co_colture);
S_cocolture.Species = string(S_cocolture.Species);
S_cocolture.Time = string(S_cocolture.Time);
S_cocolture.Properties.VariableNames{'MeanBacterialCounts_cellsML_1_'} = 'Measurements';

%% CLEANING DATA TABLES

Stat_mono_M = S_monocolture.Measurements(S_monocolture.Time == "48 h");
Stat_mono_S = S_monocolture.SE(S_monocolture.Time == "48 h");

Time = [0; 8; 16; 24; 32; 48];

TimeM_X1_S12 = S_cocolture.Measurements(S_cocolture.Co_colture == 'LP vs LA' & S_cocolture.Species == 'LP');
TimeM_X2_S12 = S_cocolture.Measurements(S_cocolture.Co_colture == 'LP vs LA' & S_cocolture.Species == 'LA');
TimeS_X1_S12 = S_cocolture.SE(S_cocolture.Co_colture == 'LP vs LA' & S_cocolture.Species == 'LP');
TimeS_X2_S12 = S_cocolture.SE(S_cocolture.Co_colture == 'LP vs LA' & S_cocolture.Species == 'LA');
SD_X1_S12 = TimeS_X1_S12 .* sqrt(2);
SD_X2_S12 = TimeS_X2_S12 .* sqrt(2);
CV_X1_S12 = SD_X1_S12 ./ TimeM_X1_S12;
CV_X2_S12 = SD_X2_S12 ./ TimeM_X2_S12;
Time_S12 = table(Time, TimeM_X1_S12, TimeS_X1_S12, SD_X1_S12, CV_X1_S12, TimeM_X2_S12, TimeS_X2_S12, SD_X2_S12, CV_X2_S12,  ...
    'VariableNames', {'Time', 'LP_mean', 'LP_SE', 'LP_SD', 'LP_CV', 'LA_mean', 'LA_SE', 'LA_SD', 'LA_CV'});

TimeM_X1_S13 = S_cocolture.Measurements(S_cocolture.Co_colture == 'LP vs BL' & S_cocolture.Species == 'LP');
TimeM_X3_S13 = S_cocolture.Measurements(S_cocolture.Co_colture == 'LP vs BL' & S_cocolture.Species == 'BL');
TimeS_X1_S13 = S_cocolture.SE(S_cocolture.Co_colture == 'LP vs BL' & S_cocolture.Species == 'LP');
TimeS_X3_S13 = S_cocolture.SE(S_cocolture.Co_colture == 'LP vs BL' & S_cocolture.Species == 'BL');
SD_X1_S13 = TimeS_X1_S13 .* sqrt(2);
SD_X3_S13 = TimeS_X3_S13 .* sqrt(2);
CV_X1_S13 = SD_X1_S13 ./ TimeM_X1_S13;
CV_X3_S13 = SD_X3_S13 ./ TimeM_X3_S13;
Time_S13 = table(Time, ...
    TimeM_X1_S13, TimeS_X1_S13, SD_X1_S13, CV_X1_S13, ...
    TimeM_X3_S13, TimeS_X3_S13, SD_X3_S13, CV_X3_S13, ...
    'VariableNames', {'Time', ...
    'LP_mean', 'LP_SE', 'LP_SD', 'LP_CV', ...
    'BL_mean', 'BL_SE', 'BL_SD', 'BL_CV'});

TimeM_X2_S23 = S_cocolture.Measurements(S_cocolture.Co_colture == 'LA vs BL' & S_cocolture.Species == 'LA');
TimeM_X3_S23 = S_cocolture.Measurements(S_cocolture.Co_colture == 'LA vs BL' & S_cocolture.Species == 'BL');
TimeS_X2_S23 = S_cocolture.SE(S_cocolture.Co_colture == 'LA vs BL' & S_cocolture.Species == 'LA');
TimeS_X3_S23 = S_cocolture.SE(S_cocolture.Co_colture == 'LA vs BL' & S_cocolture.Species == 'BL');
SD_X2_S23 = TimeS_X2_S23 .* sqrt(2);
SD_X3_S23 = TimeS_X3_S23 .* sqrt(2);
CV_X2_S23 = SD_X2_S23 ./ TimeM_X2_S23;
CV_X3_S23 = SD_X3_S23 ./ TimeM_X3_S23;
Time_S23 = table(Time, ...
    TimeM_X2_S23, TimeS_X2_S23, SD_X2_S23, CV_X2_S23, ...
    TimeM_X3_S23, TimeS_X3_S23, SD_X3_S23, CV_X3_S23, ...
    'VariableNames', {'Time', ...
    'LA_mean', 'LA_SE', 'LA_SD', 'LA_CV', ...
    'BL_mean', 'BL_SE', 'BL_SD', 'BL_CV'});

%% STATIONARY DATA - FIGURE 8
% Measured ratios X_i,ij/X_i,i at 48 h and stability boundary
% Boundary X_i,ij/X_i,i + X_j,ij/X_j,j = 1

S_mono_pro = S_monocolture((S_monocolture.Time == '48 h') & (ismember(S_monocolture.Species, ["LP", "LA", "BL"])), :);

S_mono_pro.SD = S_mono_pro.SE .* sqrt(2);
S_mono_pro.CV = S_mono_pro.SD ./ S_mono_pro.Measurements; 

Ratio_1_12 = Time_S12.LP_mean(Time_S12.Time == 48) / S_mono_pro.Measurements(S_mono_pro.Species == 'LP');
Ratio_2_12 = Time_S12.LA_mean(Time_S12.Time == 48) / S_mono_pro.Measurements(S_mono_pro.Species == 'LA');
Stab12 = Ratio_1_12 + Ratio_2_12;

Ratio_1_13 = Time_S13.LP_mean(Time_S13.Time == 48) / S_mono_pro.Measurements(S_mono_pro.Species == 'LP');
Ratio_3_13 = Time_S13.BL_mean(Time_S13.Time == 48) / S_mono_pro.Measurements(S_mono_pro.Species == 'BL');
Stab13 = Ratio_1_13 + Ratio_3_13;

Ratio_2_23 = Time_S23.LA_mean(Time_S23.Time == 48) / S_mono_pro.Measurements(S_mono_pro.Species == 'LA');
Ratio_3_23 = Time_S23.BL_mean(Time_S23.Time == 48) / S_mono_pro.Measurements(S_mono_pro.Species == 'BL');
Stab23 = Ratio_2_23 + Ratio_3_23;

frac_lin_x = linspace(5e-6, 1-5e-6, 100000);
frac_lin_y = 1 - frac_lin_x;

figure(1)

loglog(frac_lin_x, frac_lin_y, 'k-', 'LineWidth', 1.5)
hold on

loglog(Ratio_1_12, Ratio_2_12, ...
    'ko', 'MarkerFaceColor', 'b', 'MarkerSize', 14)

text(Ratio_1_12*0.53, Ratio_2_12, 'S12', ...
    'FontWeight', 'bold', ...
    'FontSize', 18)

loglog(Ratio_1_13, Ratio_3_13, ...
    'ko', 'MarkerFaceColor', 'b', 'MarkerSize', 14)

text(Ratio_1_13, Ratio_3_13*1.30, 'S13', ...
    'FontWeight', 'bold', ...
    'FontSize', 18)

loglog(Ratio_2_23, Ratio_3_23, ...
    'ko', 'MarkerFaceColor', 'b', 'MarkerSize', 14)

text(Ratio_2_23, Ratio_3_23*1.28, 'S23', ...
    'FontWeight', 'bold', ...
    'FontSize', 18)

ax = gca;

ax.FontSize = 12;       

xlabel('X_{i,ij}/X_{i,i}', ...
    'FontSize',14, ...
    'FontWeight','normal', ...
    'FontName','Arial');

ylabel('X_{j,ij}/X_{j,j}', ...
    'FontSize',14, ...
    'FontWeight','normal', ...
    'FontName','Arial', ...
    'Rotation', 0, ...
    'Units', 'Normalized', ...
    'Position', [-0.0545, 0.500, 0]);

ax.XLabel.FontSize = 19;
ax.YLabel.FontSize = 19;

xlim([5e-6 1e2])
xticks(10.^(-5:2))
ylim([1e-3 1e1])

grid on
hold off

%% PERTURBED DATASETS GENERATION - FIGURE 2
% dim lognormal realizations of the stationary data (CV from measurements)

dim = 3000; % Number of generated datasets

%LP
X1_1 = S_mono_pro.Measurements(S_mono_pro.Species == 'LP');
CV1_1 = S_mono_pro.CV(S_mono_pro.Species == 'LP');
        
%LA
X2_2 = S_mono_pro.Measurements(S_mono_pro.Species == 'LA');
CV2_2 = S_mono_pro.CV(S_mono_pro.Species == 'LA'); 
        
%BL 
X3_3 = S_mono_pro.Measurements(S_mono_pro.Species == 'BL'); 
CV3_3 = S_mono_pro.CV(S_mono_pro.Species == 'BL'); 
        
%LPLA
X1_12 = Time_S12.LP_mean(Time_S12.Time == 48);
CV1_12 = Time_S12.LP_CV(Time_S12.Time == 48);
X2_12 = Time_S12.LA_mean(Time_S12.Time == 48); 
CV2_12 = Time_S12.LA_CV(Time_S12.Time == 48);
        
%LPBL
X1_13 = Time_S13.LP_mean(Time_S13.Time == 48); 
CV1_13 = Time_S13.LP_CV(Time_S13.Time == 48);
X3_13 = Time_S13.BL_mean(Time_S13.Time == 48); 
CV3_13 = Time_S13.BL_CV(Time_S13.Time == 48);
        
%LABL 
X2_23 = Time_S23.LA_mean(Time_S23.Time == 48); 
CV2_23 = Time_S23.LA_CV(Time_S23.Time == 48);
X3_23 = Time_S23.BL_mean(Time_S23.Time == 48);
CV3_23 = Time_S23.BL_CV(Time_S23.Time == 48);

X = [X1_1 X2_2 X3_3 X1_12 X2_12 X1_13 X3_13 X2_23 X3_23];
CV = [CV1_1 CV2_2 CV3_3 CV1_12 CV2_12 CV1_13 CV3_13 CV2_23 CV3_23];

rng(1, 'twister')
Xpert = lognormal_noise(X, CV, dim);
     
% Plot: one color per co-culture (S12 orange, S13 blue, S23 magenta)
% dark = stable
% light = unstable 
c12 = [0.927 0.621 0.350];  c13 = [0.250 0.585 0.776];  c23 = [0.800 0.247 0.604];

dark  = @(c) c*0.85;                
light = @(c) c + (1-c)*0.60;      

frac_lin_x = linspace(5e-6, 1-5e-6, 100000);
frac_lin_y = 1 - frac_lin_x;

figTOT = figure;
axtot = axes(figTOT);
hold(axtot,'on')

axtot.XScale = 'log';
axtot.YScale = 'log';
        
plot(axtot, frac_lin_x, frac_lin_y, ...
     'k-', ...
     'LineWidth',1.5)
        
axtot.FontSize = 12;
        
xlabel(axtot,'X_{i,ij}/X_{i,i}', ...
       'FontSize',14, ...
       'FontWeight','normal', ...
       'FontName','Arial');
        
ylabel(axtot,'X_{j,ij}/X_{j,j}', ...
       'FontSize',14, ...
       'FontWeight','normal', ...
       'FontName','Arial', ...
       'Rotation',0, ...
       'Units','normalized', ...
       'Position',[-0.0545 0.500 0]);

axtot.XLabel.FontSize = 19;
axtot.YLabel.FontSize = 19;
        
xlim([5e-6 1e2])
xticks(10.^(-5:2))
ylim([1e-3 1e1])
        
grid(axtot,'on')
       
for cc=1:dim

    X12 = Xpert(cc,4)/Xpert(cc,1);
    Y12 = Xpert(cc,5)/Xpert(cc,2);
        
    X13 = Xpert(cc,6)/Xpert(cc,1);
    Y13 = Xpert(cc,7)/Xpert(cc,3);
        
    X23 = Xpert(cc,8)/Xpert(cc,2);
    Y23 = Xpert(cc,9)/Xpert(cc,3);
        
    Stab12_c = X12 + Y12;
    Stab13_c = X13 + Y13;
    Stab23_c = X23 + Y23;
    
  if Stab12_c>1
        scatter(axtot, X12, Y12, 80, dark(c12), '.', 'MarkerEdgeAlpha',0.35)
  else 
        scatter(axtot, X12, Y12, 80, light(c12), '.', 'MarkerEdgeAlpha',0.10)
  end

  if Stab13_c>1
         scatter(axtot, X13, Y13, 80, dark(c13), '.', 'MarkerEdgeAlpha',0.35)
  else 
         scatter(axtot, X13, Y13, 80, light(c13), '.', 'MarkerEdgeAlpha',0.10)
  end
        
  if Stab23_c>1
         scatter(axtot, X23, Y23, 80, dark(c23), '.', 'MarkerEdgeAlpha',0.35)
  else 
         scatter(axtot, X23, Y23, 80, light(c23), '.', 'MarkerEdgeAlpha',0.10)
  end

 end
        
plot(axtot, Ratio_1_12, Ratio_2_12, 'ko', 'MarkerFaceColor', 'b', 'MarkerSize', 14) 
text(axtot, Ratio_1_12*0.53, Ratio_2_12, 'S12', 'FontWeight', 'bold', 'FontSize', 18)
plot(axtot, Ratio_1_13, Ratio_3_13,  'ko', 'MarkerFaceColor', 'b', 'MarkerSize', 14) 
text(axtot, Ratio_1_13*6.8, Ratio_3_13*2.38, 'S13', 'FontWeight', 'bold', 'FontSize', 18)
plot(axtot, Ratio_2_23, Ratio_3_23,  'ko', 'MarkerFaceColor', 'b', 'MarkerSize', 14)
text(axtot,Ratio_2_23, Ratio_3_23*1.30, 'S23', 'FontWeight', 'bold', 'FontSize', 18)
