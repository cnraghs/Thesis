%LCE Plotter
clear all
clc; close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Read Data from CSV File saved from ADExl  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numHeaderRows       = 0;	% change as per simulation settings. Value = Row number of first valid corner (- 1);
numHeaderColumns    = 2;    % change as per ADExl save settings. Value = Column number of first required result column (- 1);

fileIdentifierStr   = '/home/raghunan/work/Matlab/Corners/OTA/PVT_max';
inputFilename       = strcat(fileIdentifierStr, '.csv');
inputFile           = fullfile(inputFilename);
outputFileNameStr   = [fileIdentifierStr];
outputFilename      = strcat(fileIdentifierStr, '.pdf');
outputPDF           = fullfile(outputFilename);
outputFilename      = strcat(fileIdentifierStr, '.pdf');
outputEPSStr        = strcat(outputFileNameStr, '.eps');
outputEPS           = fullfile(fileparts(pwd),outputEPSStr);

if exist(inputFile)  ~= 2
    disp('ERROR !!! File not found. Please verify if the file name provided is correct');
    disp(['File name provided : ', inputFile]);
    return;
else
    disp(['Reading file: ', inputFile]);
end

dataTable = readtable(inputFile,'HeaderLines', numHeaderRows,'Delimiter',',','ReadVariableNames',true);  % header rows are not read
disp(['CSV Data Read from file: ', inputFile]);

x=dataTable;
writetable(x,strcat(outputFileNameStr, '.csv'))

gain = table2array(x(:,9));
bw = table2array(x(:,10))/1e6;
pm = table2array(x(:,11));
zin = table2array(x(:,12))/1e6;
zout = table2array(x(:,13))/1e3;
dco = table2array(x(:,14));
irn = table2array(x(:,15))*1e9;
psrrp = table2array(x(:,16))*1e9;
psrrn = table2array(x(:,17))*1e9;
hd2 = table2array(x(:,22));
hd3 = table2array(x(:,23));
vp2p = table2array(x(:,24));
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Defining PDF properties   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Full width 1 Plot
pdfposition_multiple =[0.3  0  14  8.5];         % [left, bottom, width, height]
pdfsize_multiple=[15 9.5];                      % [width  height]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Setting properties for plot   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Full width 1 Plot
drawable_area_multiple    =[0.3  0.3  14  8];                  % [left, bottom, width, height] (cm)

%       Plot position for Full width plot
plotarea_multiple_a     = [1.5, 9.3, 12, 2];          % [left, bottom, width, height]
plotarea_multiple_b     = [1.5, 6.6, 12, 2];
plotarea_multiple_c     = [1.7, 1.5, 12, 6];
plotarea_multiple_c2    = [1.5, 9.2, 12, 6];          % used when there are two plots
plotarea_multiple_d     = [1.5, 1.2, 12, 4];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure1 = figure(1);
figure1.Units = 'centimeters';                                  % default unit is pixel.

% Define Y-Label Position
ylabelpos=2;

set(gcf,'paperunits','centimeters')             % specifies the units used in defining various dimensions
set(gcf,'position',drawable_area_multiple)
set(gcf,'paperposition',pdfposition_multiple)
set(gcf,'papersize',pdfsize_multiple)

%       Create axes
axes1 = axes('Parent',figure1,...
    'Units','centimeters',...
    'Position',plotarea_multiple_c,...  %Plot position
    'FontName','Times');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--- Get PDF & Plot properties ---%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
histogram(gain,15)
hold off

ylabel('Number of Samples','Interpreter','latex','FontSize',12,'FontName','Times');
xlabel('Gain (dB)','Interpreter','latex','FontSize',12,'FontName','Times'); % left y-axis 
TextLocation(['Mean = ' num2str(mean(gain)) ' dB',newline,'STD = ' num2str(std(gain)) ' dB'],'Location','best');

grid('on');
box('on');

%%%%%%%%%%%%%%%%%%%%%
%      save PDF     %
%%%%%%%%%%%%%%%%%%%%%
saveas(figure1,strcat(outputFileNameStr,'_gain.pdf'));

%%%%%%%%%%%%%%%%%%%%%
%      save as Image     %
%%%%%%%%%%%%%%%%%%%%%
print(figure1,'-dsvg',strcat(outputFileNameStr,'_gain'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%HD2

figure2 = figure(2);
figure2.Units = 'centimeters';                                  % default unit is pixel.

% Define Y-Label Position
ylabelpos=2;

set(gcf,'paperunits','centimeters')             % specifies the units used in defining various dimensions
set(gcf,'position',drawable_area_multiple)
set(gcf,'paperposition',pdfposition_multiple)
set(gcf,'papersize',pdfsize_multiple)

%       Create axes
axes1 = axes('Parent',figure2,...
    'Units','centimeters',...
    'Position',plotarea_multiple_c,...  %Plot position
    'FontName','Times');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--- Get PDF & Plot properties ---%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
histogram(bw,15)
hold off

ylabel('Number of Samples','Interpreter','latex','FontSize',12,'FontName','Times');
xlabel('Bandwidth (MHz)','Interpreter','latex','FontSize',12,'FontName','Times'); % left y-axis 
TextLocation(['Mean = ' num2str(mean(bw)) ' MHz',newline,'STD = ' num2str(std(bw)) ' MHz'],'Location','best');

grid('on');
box('on');

%%%%%%%%%%%%%%%%%%%%%
%      save PDF     %
%%%%%%%%%%%%%%%%%%%%%
saveas(figure2,strcat(outputFileNameStr,'_bw.pdf'));

%%%%%%%%%%%%%%%%%%%%%
%      save as Image     %
%%%%%%%%%%%%%%%%%%%%%
print(figure2,'-dsvg',strcat(outputFileNameStr,'_bw'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%HD3

figure3 = figure(3);
figure3.Units = 'centimeters';                                  % default unit is pixel.

% Define Y-Label Position
ylabelpos=2;

set(gcf,'paperunits','centimeters')             % specifies the units used in defining various dimensions
set(gcf,'position',drawable_area_multiple)
set(gcf,'paperposition',pdfposition_multiple)
set(gcf,'papersize',pdfsize_multiple)

%       Create axes
axes1 = axes('Parent',figure3,...
    'Units','centimeters',...
    'Position',plotarea_multiple_c,...  %Plot position
    'FontName','Times');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--- Get PDF & Plot properties ---%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
histogram(pm,15)
hold off

ylabel('Number of Samples','Interpreter','latex','FontSize',12,'FontName','Times');
xlabel('Phase Margin','Interpreter','latex','FontSize',12,'FontName','Times'); % left y-axis 
TextLocation({['Mean = ' num2str(mean(pm)) ' degrees',newline,'STD = ' num2str(std(pm)) ' degrees']},'Location','best');

grid('on');
box('on');

%%%%%%%%%%%%%%%%%%%%%
%      save PDF     %
%%%%%%%%%%%%%%%%%%%%%
saveas(figure3,strcat(outputFileNameStr,'_pm.pdf'));

%%%%%%%%%%%%%%%%%%%%%
%      save as Image     %
%%%%%%%%%%%%%%%%%%%%%
print(figure3,'-dsvg',strcat(outputFileNameStr,'_pm'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Phase_noise
figure4 = figure(4);
figure4.Units = 'centimeters';                                  % default unit is pixel.

% Define Y-Label Position
ylabelpos=2;

set(gcf,'paperunits','centimeters')             % specifies the units used in defining various dimensions
set(gcf,'position',drawable_area_multiple)
set(gcf,'paperposition',pdfposition_multiple)
set(gcf,'papersize',pdfsize_multiple)

%       Create axes
axes1 = axes('Parent',figure4,...
    'Units','centimeters',...
    'Position',plotarea_multiple_c,...  %Plot position
    'FontName','Times');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--- Get PDF & Plot properties ---%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
histogram(zin,15)
hold off

ylabel('Number of Samples','Interpreter','latex','FontSize',12,'FontName','Times');
xlabel('Input Impedance (Mega Ohms)','Interpreter','latex','FontSize',12,'FontName','Times'); % left y-axis 
TextLocation({['Mean = ' num2str(mean(zin)) 'Mega Ohms',newline,'STD = ' num2str(std(zin)) 'Mega Ohms']},'Location','best');
grid('on');
box('on');

%%%%%%%%%%%%%%%%%%%%%
%      save PDF     %
%%%%%%%%%%%%%%%%%%%%%
saveas(figure4,strcat(outputFileNameStr,'_zin.pdf'));

%%%%%%%%%%%%%%%%%%%%%
%      save as Image     %
%%%%%%%%%%%%%%%%%%%%%
print(figure4,'-dsvg',strcat(outputFileNameStr,'_zin'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure5 = figure(5);
figure5.Units = 'centimeters';                                  % default unit is pixel.

% Define Y-Label Position
ylabelpos=2;

set(gcf,'paperunits','centimeters')             % specifies the units used in defining various dimensions
set(gcf,'position',drawable_area_multiple)
set(gcf,'paperposition',pdfposition_multiple)
set(gcf,'papersize',pdfsize_multiple)

%       Create axes
axes1 = axes('Parent',figure5,...
    'Units','centimeters',...
    'Position',plotarea_multiple_c,...  %Plot position
    'FontName','Times');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--- Get PDF & Plot properties ---%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
histogram(zout,15)
hold off

ylabel('Number of Samples','Interpreter','latex','FontSize',12,'FontName','Times');
xlabel('Output Impedance (Kilo Ohms)','Interpreter','latex','FontSize',12,'FontName','Times'); % left y-axis 
TextLocation(['Mean = ' num2str(mean(zout)) ' Kilo Ohms',newline,'STD = ' num2str(std(zout)) ' Kilo Ohms'],'Location','best');
grid('on');
box('on');

%%%%%%%%%%%%%%%%%%%%%
%      save PDF     %
%%%%%%%%%%%%%%%%%%%%%
saveas(figure5,strcat(outputFileNameStr,'_zout.pdf'));

%%%%%%%%%%%%%%%%%%%%%
%      save as Image     %
%%%%%%%%%%%%%%%%%%%%%
print(figure5,'-dsvg',strcat(outputFileNameStr,'_zout'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure6 = figure(6);
figure6.Units = 'centimeters';                                  % default unit is pixel.

% Define Y-Label Position
ylabelpos=2;

set(gcf,'paperunits','centimeters')             % specifies the units used in defining various dimensions
set(gcf,'position',drawable_area_multiple)
set(gcf,'paperposition',pdfposition_multiple)
set(gcf,'papersize',pdfsize_multiple)

%       Create axes
axes1 = axes('Parent',figure6,...
    'Units','centimeters',...
    'Position',plotarea_multiple_c,...  %Plot position
    'FontName','Times');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--- Get PDF & Plot properties ---%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
histogram(dco,15)
hold off

ylabel('Number of Samples','Interpreter','latex','FontSize',12,'FontName','Times');
xlabel('Output DC Bias Voltage (Volts)','Interpreter','latex','FontSize',12,'FontName','Times'); % left y-axis 
TextLocation(['Mean = ' num2str(mean(dco)) ' Volts',newline,'STD = ' num2str(std(dco)) ' Volts'],'Location','best');
grid('on');
box('on');

%%%%%%%%%%%%%%%%%%%%%
%      save PDF     %
%%%%%%%%%%%%%%%%%%%%%
saveas(figure6,strcat(outputFileNameStr,'_dco.pdf'));

%%%%%%%%%%%%%%%%%%%%%
%      save as Image     %
%%%%%%%%%%%%%%%%%%%%%
print(figure6,'-dsvg',strcat(outputFileNameStr,'_dco'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure7 = figure(7);
figure7.Units = 'centimeters';                                  % default unit is pixel.

% Define Y-Label Position
ylabelpos=2;

set(gcf,'paperunits','centimeters')             % specifies the units used in defining various dimensions
set(gcf,'position',drawable_area_multiple)
set(gcf,'paperposition',pdfposition_multiple)
set(gcf,'papersize',pdfsize_multiple)

%       Create axes
axes1 = axes('Parent',figure7,...
    'Units','centimeters',...
    'Position',plotarea_multiple_c,...  %Plot position
    'FontName','Times');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--- Get PDF & Plot properties ---%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
histogram(irn,15)
hold off

ylabel('Number of Samples','Interpreter','latex','FontSize',12,'FontName','Times');
xlabel('Input Referred Noise (nV/sqrt(Hz))','Interpreter','latex','FontSize',12,'FontName','Times'); % left y-axis 
TextLocation(['Mean = ' num2str(mean(irn)) ' nV/sqrt(Hz)',newline,'STD = ' num2str(std(irn)) ' nV/sqrt(Hz)'],'Location','best');
grid('on');
box('on');

%%%%%%%%%%%%%%%%%%%%%
%      save PDF     %
%%%%%%%%%%%%%%%%%%%%%
saveas(figure7,strcat(outputFileNameStr,'_irn.pdf'));

%%%%%%%%%%%%%%%%%%%%%
%      save as Image     %
%%%%%%%%%%%%%%%%%%%%%
print(figure7,'-dsvg',strcat(outputFileNameStr,'_irn'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure8 = figure(8);
figure8.Units = 'centimeters';                                  % default unit is pixel.

% Define Y-Label Position
ylabelpos=2;

set(gcf,'paperunits','centimeters')             % specifies the units used in defining various dimensions
set(gcf,'position',drawable_area_multiple)
set(gcf,'paperposition',pdfposition_multiple)
set(gcf,'papersize',pdfsize_multiple)

%       Create axes
axes1 = axes('Parent',figure8,...
    'Units','centimeters',...
    'Position',plotarea_multiple_c,...  %Plot position
    'FontName','Times');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--- Get PDF & Plot properties ---%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
histogram(psrrp,15)
hold off

ylabel('Number of Samples','Interpreter','latex','FontSize',12,'FontName','Times');
xlabel('PSRR of VDD (nA/V)','Interpreter','latex','FontSize',12,'FontName','Times'); % left y-axis 
TextLocation(['Mean = ' num2str(mean(psrrp)) ' nA/V',newline,'STD = ' num2str(std(psrrp)) ' nA/V'],'Location','best');
grid('on');
box('on');

%%%%%%%%%%%%%%%%%%%%%
%      save PDF     %
%%%%%%%%%%%%%%%%%%%%%
saveas(figure8,strcat(outputFileNameStr,'_psrrp.pdf'));

%%%%%%%%%%%%%%%%%%%%%
%      save as Image     %
%%%%%%%%%%%%%%%%%%%%%
print(figure8,'-dsvg',strcat(outputFileNameStr,'_psrrp'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure9 = figure(9);
figure9.Units = 'centimeters';                                  % default unit is pixel.

% Define Y-Label Position
ylabelpos=2;

set(gcf,'paperunits','centimeters')             % specifies the units used in defining various dimensions
set(gcf,'position',drawable_area_multiple)
set(gcf,'paperposition',pdfposition_multiple)
set(gcf,'papersize',pdfsize_multiple)

%       Create axes
axes1 = axes('Parent',figure9,...
    'Units','centimeters',...
    'Position',plotarea_multiple_c,...  %Plot position
    'FontName','Times');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--- Get PDF & Plot properties ---%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
histogram(psrrn,15)
hold off

ylabel('Number of Samples','Interpreter','latex','FontSize',12,'FontName','Times');
xlabel('PSRR of VSS (nA/V)','Interpreter','latex','FontSize',12,'FontName','Times'); % left y-axis 
TextLocation(['Mean = ' num2str(mean(psrrn)) ' nA/V',newline,'STD = ' num2str(std(psrrn)) ' nA/V'],'Location','best');
grid('on');
box('on');

%%%%%%%%%%%%%%%%%%%%%
%      save PDF     %
%%%%%%%%%%%%%%%%%%%%%
saveas(figure9,strcat(outputFileNameStr,'_psrrn.pdf'));

%%%%%%%%%%%%%%%%%%%%%
%      save as Image     %
%%%%%%%%%%%%%%%%%%%%%
print(figure9,'-dsvg',strcat(outputFileNameStr,'_psrrn'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure10 = figure(10);
figure10.Units = 'centimeters';                                  % default unit is pixel.

% Define Y-Label Position
ylabelpos=2;

set(gcf,'paperunits','centimeters')             % specifies the units used in defining various dimensions
set(gcf,'position',drawable_area_multiple)
set(gcf,'paperposition',pdfposition_multiple)
set(gcf,'papersize',pdfsize_multiple)

%       Create axes
axes1 = axes('Parent',figure10,...
    'Units','centimeters',...
    'Position',plotarea_multiple_c,...  %Plot position
    'FontName','Times');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--- Get PDF & Plot properties ---%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
histogram(hd2,15)
hold off

ylabel('Number of Samples','Interpreter','latex','FontSize',12,'FontName','Times');
xlabel('Magnitude of HD2 (dBc)','Interpreter','latex','FontSize',12,'FontName','Times'); % left y-axis 
TextLocation(['Mean = ' num2str(mean(hd2)) ' dBc',newline,'STD = ' num2str(std(hd2)) ' dBc'],'Location','best');
grid('on');
box('on');

%%%%%%%%%%%%%%%%%%%%%
%      save PDF     %
%%%%%%%%%%%%%%%%%%%%%
saveas(figure10,strcat(outputFileNameStr,'_hd2.pdf'));

%%%%%%%%%%%%%%%%%%%%%
%      save as Image     %
%%%%%%%%%%%%%%%%%%%%%
print(figure10,'-dsvg',strcat(outputFileNameStr,'_hd2'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure11 = figure(11);
figure11.Units = 'centimeters';                                  % default unit is pixel.

% Define Y-Label Position
ylabelpos=2;

set(gcf,'paperunits','centimeters')             % specifies the units used in defining various dimensions
set(gcf,'position',drawable_area_multiple)
set(gcf,'paperposition',pdfposition_multiple)
set(gcf,'papersize',pdfsize_multiple)

%       Create axes
axes1 = axes('Parent',figure11,...
    'Units','centimeters',...
    'Position',plotarea_multiple_c,...  %Plot position
    'FontName','Times');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--- Get PDF & Plot properties ---%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
histogram(hd3,15)
hold off

ylabel('Number of Samples','Interpreter','latex','FontSize',12,'FontName','Times');
xlabel('Magnitude of HD3 (dBc)','Interpreter','latex','FontSize',12,'FontName','Times'); % left y-axis 
TextLocation(['Mean = ' num2str(mean(hd3)) ' dBc',newline,'STD = ' num2str(std(hd3)) ' dBc'],'Location','best');
grid('on');
box('on');

%%%%%%%%%%%%%%%%%%%%%
%      save PDF     %
%%%%%%%%%%%%%%%%%%%%%
saveas(figure11,strcat(outputFileNameStr,'_hd3.pdf'));

%%%%%%%%%%%%%%%%%%%%%
%      save as Image     %
%%%%%%%%%%%%%%%%%%%%%
print(figure11,'-dsvg',strcat(outputFileNameStr,'_hd3'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure12 = figure(12);
figure12.Units = 'centimeters';                                  % default unit is pixel.

% Define Y-Label Position
ylabelpos=2;

set(gcf,'paperunits','centimeters')             % specifies the units used in defining various dimensions
set(gcf,'position',drawable_area_multiple)
set(gcf,'paperposition',pdfposition_multiple)
set(gcf,'papersize',pdfsize_multiple)

%       Create axes
axes1 = axes('Parent',figure12,...
    'Units','centimeters',...
    'Position',plotarea_multiple_c,...  %Plot position
    'FontName','Times');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--- Get PDF & Plot properties ---%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
histogram(vp2p,15)
hold off

ylabel('Number of Samples','Interpreter','latex','FontSize',12,'FontName','Times');
xlabel('Output Voltage Swing (Volts)','Interpreter','latex','FontSize',12,'FontName','Times'); % left y-axis 
TextLocation(['Mean = ' num2str(mean(vp2p)) ' Volts',newline,'STD = ' num2str(std(vp2p)) ' Volts'],'Location','best');
grid('on');
box('on');

%%%%%%%%%%%%%%%%%%%%%
%      save PDF     %
%%%%%%%%%%%%%%%%%%%%%
saveas(figure12,strcat(outputFileNameStr,'_vp2p.pdf'));

%%%%%%%%%%%%%%%%%%%%%
%      save as Image     %
%%%%%%%%%%%%%%%%%%%%%
print(figure12,'-dsvg',strcat(outputFileNameStr,'_vp2p'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
